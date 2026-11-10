import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_quotes_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/data/quotes_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/domain/user_model.dart';
import 'package:wolnelektury/src/enums/cache_enum.dart';
import 'package:wolnelektury/src/features/common/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

class _FakeApiService extends Fake implements ApiService {
  final List<({String endpoint, dynamic data})> posts = [];
  final List<String> gets = [];
  final List<String> deletes = [];
  ApiResponse postResponse = const ApiResponse(data: [], statusCode: 200);
  ApiResponse getResponse = const ApiResponse(data: [], statusCode: 200);

  @override
  Future<ApiResponse> postRequest(
    String endpoint,
    dynamic data, {
    String? contentType,
    bool allowRetry = true,
    required bool isAnonymous,
  }) async {
    posts.add((endpoint: endpoint, data: data));
    return postResponse;
  }

  @override
  Future<ApiResponse> getRequest(
    String endpoint, {
    bool allowRetry = true,
    CacheEnum useCache = CacheEnum.use,
    required bool isAnonymous,
  }) async {
    gets.add(endpoint);
    return getResponse;
  }

  @override
  Future<ApiResponse> deleteRequest(
    String endpoint, {
    dynamic data,
    String? contentType,
    bool allowRetry = true,
    required bool isAnonymous,
  }) async {
    deletes.add(endpoint);
    return const ApiResponse(data: [], statusCode: 204);
  }
}

class _FakeConnectivityCubit extends Fake implements ConnectivityCubit {
  bool connected = false;

  @override
  ConnectivityState get state => ConnectivityState(
    result: connected ? ConnectivityResult.wifi : ConnectivityResult.none,
  );
}

class _FakeAuthCubit extends Fake implements AuthCubit {
  @override
  AuthState get state => const AuthState(
    user: UserModel(username: 'u', confirmed: true, premium: false),
  );
}

Map<String, dynamic> _serverQuote(
  String uuid, {
  int timestamp = 100,
  bool deleted = false,
}) => {
  'uuid': uuid,
  'book': BookModel.empty(slug: 'book').toJson(),
  'start_elem': 'a1',
  'end_elem': 'a2',
  'start_offset': 1,
  'end_offset': 4,
  'text': 'server text',
  'href': 'https://wolnelektury.pl/api/4/quotes/$uuid/',
  'timestamp': timestamp,
  'deleted': deleted,
};

String _json(Map<String, dynamic> serverQuote) =>
    jsonEncode(QuoteModel.fromJson(serverQuote).toJson());

void main() {
  late AppStorage storage;
  late AppStorageQuotesService quotesStorage;
  late AppStorageSyncService syncStorage;
  late _FakeApiService api;
  late QuotesRepositoryImplementation repository;
  late _FakeConnectivityCubit connectivity;
  final book = BookModel.empty(slug: 'book');

  setUp(() {
    storage = AppStorage.forTesting(NativeDatabase.memory());
    quotesStorage = AppStorageQuotesService(storage);
    syncStorage = AppStorageSyncService(storage);
    api = _FakeApiService();
    // Offline, but logged in: repositories must fall back to local storage.
    connectivity = _FakeConnectivityCubit();
    get.registerSingleton<ConnectivityCubit>(connectivity);
    get.registerSingleton<AuthCubit>(_FakeAuthCubit());
    repository = QuotesRepositoryImplementation(
      api,
      quotesStorage,
      syncStorage,
    );
  });

  tearDown(() async {
    await get.reset();
    await storage.close();
  });

  Future<QuoteModel> createOffline() async {
    final result = await repository.createQuote(
      book: book,
      startElem: 'a1',
      endElem: 'a2',
      startOffset: 1,
      endOffset: 4,
      text: 'abc',
    );
    return (result as DataStateSuccess<QuoteModel>).data;
  }

  test('quote model survives the JSON round trip used by storage', () async {
    final created = await createOffline();
    final read = await repository.getQuotes();
    final decoded = (read as DataStateSuccess<List<QuoteModel>>).data.single;
    expect(decoded, created);
    expect(created.uuid, startsWith('local-'));
    expect(created.text, 'abc');
  });

  test('offline create does not call the API', () async {
    await createOffline();
    expect(api.posts, isEmpty);
  });

  test('sync out sends local quotes as client_id and swaps the id', () async {
    final created = await createOffline();
    api.postResponse = ApiResponse(
      data: [
        {'client_id': created.uuid, 'uuid': 'server-uuid'},
      ],
      statusCode: 200,
    );

    final result = await repository.sendOutQuotesSync();
    expect(result.isSuccess, isTrue);

    final sent = api.posts.single;
    expect(sent.endpoint, '/sync/quote/');
    final payload = (sent.data as List).single as Map<String, dynamic>;
    expect(payload['client_id'], created.uuid);
    expect(payload.containsKey('uuid'), isFalse);
    expect(payload['book_slug'], 'book');
    expect(payload['text'], 'abc');
    expect(payload['start_offset'], 1);
    expect(payload['end_offset'], 4);
    expect(payload['deleted'], false);
    expect(payload['timestamp'], isA<int>());

    final rows = await storage.select(storage.quotes).get();
    expect(rows.single.id, 'server-uuid');
    expect(
      QuoteModel.fromJson(jsonDecode(rows.single.quoteJson)).uuid,
      'server-uuid',
    );

    // Everything was sent, the next sync has nothing to send.
    expect(await syncStorage.getQuotesToSync(), isEmpty);
  });

  test('sync out is not marked as done when the request fails', () async {
    await createOffline();
    api.postResponse = const ApiResponse(error: 'Error: 500', statusCode: 500);

    final result = await repository.sendOutQuotesSync();
    expect(result.isSuccess, isFalse);
    expect(await syncStorage.getQuotesToSync(), hasLength(1));
  });

  test('deleting a synced quote is sent as a tombstone with uuid', () async {
    await quotesStorage.upsertMultipleQuotes([
      (
        id: 'server-uuid',
        slug: 'book',
        quoteJson: _json(_serverQuote('server-uuid')),
        timestamp: DateTime.fromMillisecondsSinceEpoch(1000),
        isDeleted: false,
      ),
    ]);
    await syncStorage.updateSyncData(
      sentQuotesSyncAt: DateTime.fromMillisecondsSinceEpoch(2000),
    );

    await repository.deleteQuote(
      id: 'server-uuid',
      href: 'https://wolnelektury.pl/api/4/quotes/server-uuid/',
    );
    // Offline: no remote call, but a tombstone is queued for sync.
    expect(api.deletes, isEmpty);
    expect(await repository.getQuotes(), isA<DataStateFailure>());

    await repository.sendOutQuotesSync();
    final payload =
        (api.posts.single.data as List).single as Map<String, dynamic>;
    expect(payload['uuid'], 'server-uuid');
    expect(payload['deleted'], true);
    expect(payload['text'], 'server text');
  });

  test('sync in stores quotes and drops tombstones', () async {
    await quotesStorage.upsertMultipleQuotes([
      (
        id: 'gone',
        slug: 'book',
        quoteJson: _json(_serverQuote('gone')),
        timestamp: DateTime.fromMillisecondsSinceEpoch(1000),
        isDeleted: false,
      ),
    ]);
    api.getResponse = ApiResponse(
      data: [
        _serverQuote('new', timestamp: 200),
        _serverQuote('gone', timestamp: 300, deleted: true),
      ],
      statusCode: 200,
    );
    // Receiving always follows a send-out.
    await syncStorage.updateSyncData(sentQuotesSyncAt: DateTime.now());

    final result = await repository.receiveInQuotesSync();
    expect(result.isSuccess, isTrue);
    expect(api.gets.single, '/sync/quote/?ts=0');

    final quotes = await repository.getQuotes();
    final data = (quotes as DataStateSuccess<List<QuoteModel>>).data;
    expect(data.map((e) => e.uuid), ['new']);
    expect((await syncStorage.getSyncData()).receivedQuotesSyncAt, isNotNull);
  });

  test('overlapping sync-outs send an offline quote only once', () async {
    final created = await createOffline();
    api.postResponse = ApiResponse(
      data: [
        {'client_id': created.uuid, 'uuid': 'server-uuid'},
      ],
      statusCode: 200,
    );

    await Future.wait([
      repository.sendOutQuotesSync(),
      repository.sendOutQuotesSync(),
    ]);

    expect(api.posts, hasLength(1));
  });

  test('sync in keeps local changes that were not sent yet', () async {
    await quotesStorage.upsertMultipleQuotes([
      (
        id: 'q1',
        slug: 'book',
        quoteJson: _json(_serverQuote('q1')),
        timestamp: DateTime.fromMillisecondsSinceEpoch(1000),
        isDeleted: false,
      ),
    ]);
    await syncStorage.updateSyncData(
      sentQuotesSyncAt: DateTime.fromMillisecondsSinceEpoch(2000),
    );
    // Deleted locally after the last send-out.
    await quotesStorage.deleteQuote('q1');
    api.getResponse = ApiResponse(
      data: [_serverQuote('q1', timestamp: 3)],
      statusCode: 200,
    );

    await repository.receiveInQuotesSync();

    final rows = await storage.select(storage.quotes).get();
    expect(rows.single.isDeleted, isTrue);
    expect(await syncStorage.getQuotesToSync(), hasLength(1));
  });

  test('online create works when the server does not echo the text', () async {
    connectivity.connected = true;
    api.postResponse = ApiResponse(
      data: [
        {..._serverQuote('server-uuid')..remove('text')},
      ],
      statusCode: 201,
    );

    final result = await repository.createQuote(
      book: book,
      startElem: 'a1',
      endElem: 'a2',
      startOffset: 1,
      endOffset: 4,
      text: 'abc',
    );

    final created = (result as DataStateSuccess<QuoteModel>).data;
    expect(created.uuid, 'server-uuid');
    expect(created.text, 'abc');
    expect(api.posts.single.endpoint, '/quotes/');
    expect((api.posts.single.data as Map)['text'], 'abc');
    final rows = await storage.select(storage.quotes).get();
    expect(rows.single.id, 'server-uuid');
  });

  test('sync in keeps the local text when the server omits it', () async {
    await quotesStorage.upsertMultipleQuotes([
      (
        id: 'q1',
        slug: 'book',
        quoteJson: _json({..._serverQuote('q1'), 'text': 'local text'}),
        timestamp: DateTime.fromMillisecondsSinceEpoch(1000),
        isDeleted: false,
      ),
    ]);
    await syncStorage.updateSyncData(sentQuotesSyncAt: DateTime.now());
    api.getResponse = ApiResponse(
      data: [
        {..._serverQuote('q1', timestamp: 500)..remove('text')},
      ],
      statusCode: 200,
    );

    await repository.receiveInQuotesSync();

    final quotes = await repository.getQuotes();
    final data = (quotes as DataStateSuccess<List<QuoteModel>>).data;
    expect(data.single.text, 'local text');
  });

  test('reset clears stored quotes', () async {
    await createOffline();
    await repository.reset();
    expect(await storage.select(storage.quotes).get(), isEmpty);
  });
}
