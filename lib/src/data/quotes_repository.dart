import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_quotes_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
import 'package:wolnelektury/src/data/mixin/repository_helper_mixin.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

abstract class QuotesRepository {
  Future<DataState<List<QuoteModel>>> getQuotes({
    int offset = 0,
    int limit = 20,
  });

  Future<DataState<List<QuoteModel>>> getBookQuotes({required String slug});

  Future<DataState<QuoteModel>> createQuote({
    required BookModel book,
    required String startElem,
    required String endElem,
    required int startOffset,
    required int endOffset,
    required String text,
  });

  Future<DataState<void>> deleteQuote({
    required String id,
    required String href,
  });

  Future<DataState<void>> sendOutQuotesSync();
  Future<DataState<void>> receiveInQuotesSync();

  Future<DataState<void>> reset();
}

class QuotesRepositoryImplementation extends QuotesRepository
    with RepositoryHelperMixin {
  final ApiService _apiService;
  final AppStorageQuotesService _quotesStorage;
  final AppStorageSyncService _syncStorage;

  QuotesRepositoryImplementation(
    this._apiService,
    this._quotesStorage,
    this._syncStorage,
  );

  static const String _quotesEndpoint = '/quotes/';
  static const String _sendSyncQuotesEndpoint = '/sync/quote/';
  static String _receiveSyncQuotesEndpoint(String ts) => '/sync/quote/?ts=$ts';

  @override
  Future<DataState<void>> reset() async {
    try {
      await _quotesStorage.clear();
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<QuoteModel>>> getQuotes({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _quotesStorage.getQuotes(
        offset: offset,
        limit: limit,
      );
      return _decodeQuotes(response);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<QuoteModel>>> getBookQuotes({
    required String slug,
  }) async {
    try {
      final response = await _quotesStorage.getBookQuotes(slug);
      return _decodeQuotes(response);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  DataState<List<QuoteModel>> _decodeQuotes(List<String> jsons) {
    if (jsons.isEmpty) {
      return const DataState.failure(Failure.notFound());
    }

    final List<QuoteModel> quotes = [];
    for (final e in jsons) {
      try {
        quotes.add(QuoteModel.fromJson(jsonDecode(e)));
      } catch (_) {
        // Wrong JSON, skip
      }
    }

    return DataState.success(data: quotes);
  }

  @override
  Future<DataState<QuoteModel>> createQuote({
    required BookModel book,
    required String startElem,
    required String endElem,
    required int startOffset,
    required int endOffset,
    required String text,
  }) async {
    try {
      Future<void> insertionFunction(String id, QuoteModel quote) async {
        await _quotesStorage.upsertMultipleQuotes([
          (
            id: id,
            slug: book.slug,
            quoteJson: jsonEncode(quote.toJson()),
            timestamp: DateTime.now(),
            isDeleted: false,
          ),
        ]);
      }

      // Is online, insert the remotely created quote, because it comes back
      // with the server uuid.
      if (tryOnline) {
        final dbResult = await _createQuoteInDb(
          bookSlug: book.slug,
          startElem: startElem,
          endElem: endElem,
          startOffset: startOffset,
          endOffset: endOffset,
          text: text,
        );
        if (dbResult case DataStateSuccess<QuoteModel>(:final data)) {
          await insertionFunction(data.uuid ?? _newLocalId(), data);
        }
        return dbResult;
      }

      // Is offline, just insert locally. It's sent out with the next sync.
      final localId = _newLocalId();
      final createdQuote = QuoteModel(
        uuid: localId,
        text: text,
        book: book,
        bookSlug: book.slug,
        startElem: startElem,
        endElem: endElem,
        startOffset: startOffset,
        endOffset: endOffset,
        href: '',
      );
      await insertionFunction(localId, createdQuote);
      return DataState.success(data: createdQuote);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  // Syncs run one at a time, so overlapping triggers (login, connectivity
  // restored) can't send the same offline quote twice.
  Future<void> _syncLock = Future.value();

  Future<T> _synchronized<T>(Future<T> Function() action) async {
    final previous = _syncLock;
    final released = Completer<void>();
    _syncLock = released.future;
    await previous;
    try {
      return await action();
    } finally {
      released.complete();
    }
  }

  // Quotes created offline use this id (also as their model uuid) until the
  // server assigns a real uuid during sync.
  static String _newLocalId() =>
      '$localQuoteIdPrefix${DateTime.now().microsecondsSinceEpoch}';

  @override
  Future<DataState<void>> deleteQuote({
    required String id,
    required String href,
  }) async {
    try {
      await _quotesStorage.deleteQuote(id);
      // Quotes that were never synced have nothing to delete remotely.
      if (tryOnline && href.isNotEmpty) {
        return await _deleteQuoteFromDb(href);
      }
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<QuoteModel>> _createQuoteInDb({
    required String bookSlug,
    required String startElem,
    required String endElem,
    required int startOffset,
    required int endOffset,
    required String text,
  }) async {
    try {
      final response = await _apiService.postRequest(_quotesEndpoint, {
        'book_slug': bookSlug,
        'start_elem': startElem,
        'end_elem': endElem,
        'start_offset': startOffset,
        'end_offset': endOffset,
        'text': text,
      }, isAnonymous: false);

      if ((response.data ?? []).isNotEmpty) {
        // The server may not echo the text back, so fall back to what we sent.
        return DataState.success(
          data: QuoteModel.fromJson({'text': text, ...response.data!.first}),
        );
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<void>> _deleteQuoteFromDb(String href) async {
    try {
      await _apiService.deleteRequest(href.removeApiUrl, isAnonymous: false);
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> sendOutQuotesSync() => _synchronized(() async {
    try {
      // Taken before reading the rows, so quotes changed while the request is
      // in flight are still picked up by the next sync.
      final syncStartedAt = DateTime.now();
      final quotes = await _syncStorage.getQuotesToSync();

      AppLogger.instance.d(
        'QuotesRepository',
        'Sending number of sync quotes: ${quotes.length}',
      );

      // All is up to date
      if (quotes.isEmpty) {
        await _syncStorage.updateSyncData(sentQuotesSyncAt: syncStartedAt);
        return const DataState.success(data: null);
      }

      final payload = <Map<String, dynamic>>[];
      for (final e in quotes) {
        try {
          final model = QuoteModel.fromJson(jsonDecode(e.quoteJson));
          payload.add({
            // Quotes created offline have no server uuid yet, the server maps
            // the client_id to the uuid it assigns.
            if (e.id.startsWith(localQuoteIdPrefix))
              'client_id': e.id
            else
              'uuid': e.id,
            'book_slug': e.slug,
            'start_elem': model.startElem,
            'end_elem': model.endElem,
            'start_offset': model.startOffset,
            'end_offset': model.endOffset,
            'text': model.text,
            'deleted': e.isDeleted,
            'timestamp': (e.updatedAt.millisecondsSinceEpoch) ~/ 1000,
          });
        } catch (_) {
          // Wrong JSON, skip
        }
      }

      if (payload.isEmpty) {
        await _syncStorage.updateSyncData(sentQuotesSyncAt: syncStartedAt);
        return const DataState.success(data: null);
      }

      final response = await _apiService.postRequest(
        _sendSyncQuotesEndpoint,
        payload,
        contentType: Headers.jsonContentType,
        isAnonymous: false,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      await _applyAssignedUuids({
        for (final e in quotes) e.id: e.quoteJson,
      }, response.data ?? []);

      await _syncStorage.updateSyncData(sentQuotesSyncAt: syncStartedAt);
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  });

  /// The server answers with `{client_id, uuid}` for every quote it created.
  Future<void> _applyAssignedUuids(
    Map<String, String> sentJsonById,
    List<Map<String, dynamic>> mappings,
  ) async {
    for (final mapping in mappings) {
      final clientId = mapping['client_id'];
      final uuid = mapping['uuid'];
      if (clientId is! String || uuid is! String) continue;
      final json = sentJsonById[clientId];
      if (json == null) continue;
      try {
        final model = QuoteModel.fromJson(jsonDecode(json));
        await _quotesStorage.replaceId(
          oldId: clientId,
          newId: uuid,
          quoteJson: jsonEncode(model.copyWith(uuid: uuid).toJson()),
        );
      } catch (_) {
        // Wrong JSON, skip
      }
    }
  }

  @override
  Future<DataState<void>> receiveInQuotesSync() => _synchronized(() async {
    try {
      final syncData = await _syncStorage.getSyncData();
      final lastReceived = syncData.receivedQuotesSyncAt;
      final lastReceivedTimestamp =
          ((lastReceived?.millisecondsSinceEpoch ?? 0) / 1000)
              .round()
              .toString();

      final response = await _apiService.getRequest(
        _receiveSyncQuotesEndpoint(lastReceivedTimestamp),
        useCache: CacheEnum.ignore,
        isAnonymous: false,
      );

      AppLogger.instance.d(
        'QuotesRepository',
        'Received number of sync quotes: ${response.data?.length}',
      );

      // Simply nothing to sync
      if (!response.hasData) {
        await _syncStorage.updateSyncData(receivedQuotesSyncAt: DateTime.now());
        return const DataState.failure(Failure.notFound());
      }

      // Local changes that weren't sent yet are newer than what the server
      // knows, so they must not be overwritten.
      final pendingIds = (await _syncStorage.getQuotesToSync())
          .map((e) => e.id)
          .toSet();
      final List<QuoteModel> quotes = [];

      for (final e in response.data!) {
        try {
          var quoteModel = QuoteModel.fromJson(e);
          final uuid = quoteModel.uuid;
          if (uuid == null || pendingIds.contains(uuid)) continue;
          // Don't lose the text we already have when the server omits it.
          if (quoteModel.text.isEmpty) {
            final localJson = await _quotesStorage.getQuoteJson(uuid);
            if (localJson != null) {
              final localText = QuoteModel.fromJson(jsonDecode(localJson)).text;
              quoteModel = quoteModel.copyWith(text: localText);
            }
          }
          quotes.add(quoteModel);
        } catch (_) {
          // Wrong JSON, skip
        }
      }

      await _quotesStorage.upsertMultipleQuotes(
        quotes.map((e) {
          final updatedAt = DateTime.fromMillisecondsSinceEpoch(
            // Null timestamp shouldn't ever happen, but just in case
            (e.timestamp ?? 0) * 1000,
          );
          return (
            slug: e.book.slug,
            id: e.uuid!,
            quoteJson: jsonEncode(e.toJson()),
            isDeleted: e.deleted,
            timestamp: updatedAt,
          );
        }).toList(),
      );

      await _syncStorage.updateSyncData(receivedQuotesSyncAt: DateTime.now());
      // Only tombstones that were already sent out can be dropped.
      final sentAt = (await _syncStorage.getSyncData()).sentQuotesSyncAt;
      if (sentAt != null) {
        await _quotesStorage.clearDeleted(sentUntil: sentAt);
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  });
}
