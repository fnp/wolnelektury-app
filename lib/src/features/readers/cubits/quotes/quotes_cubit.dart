import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/quotes_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/enums/success_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'quotes_cubit.freezed.dart';
part 'quotes_state.dart';

class QuotesCubit extends SafeCubit<QuotesState> {
  static const int _pageSize = 20;

  final QuotesRepository _quotesRepository;

  QuotesCubit(this._quotesRepository) : super(const QuotesState());

  // --------------------------
  // ------- My Library -------
  // --------------------------

  Future<void> getMyLibraryQuotes() async {
    emit(state.copyWith(isLoading: true));
    final quotes = await _quotesRepository.getQuotes(limit: _pageSize);
    quotes.handle(
      success: (data, _) {
        emit(
          state.copyWith(
            quotes: data,
            isLoading: false,
            canLoadMore: data.length >= _pageSize,
          ),
        );
      },
      failure: (error) {
        error.handle(
          notFound: () {
            emit(
              state.copyWith(quotes: [], isLoading: false, canLoadMore: false),
            );
          },
          orElse: () {
            emit(state.copyWith(isLoading: false));
          },
        );
      },
    );
  }

  Future<void> getMoreMyLibraryQuotes() async {
    if (!state.canLoadMore || state.isLoadingMore || state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true));
    final quotes = await _quotesRepository.getQuotes(
      offset: state.quotes.length,
      limit: _pageSize,
    );

    quotes.handle(
      success: (data, _) {
        emit(
          state.copyWith(
            quotes: [...state.quotes, ...data],
            isLoadingMore: false,
            canLoadMore: data.length >= _pageSize,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingMore: false, canLoadMore: false));
      },
    );
  }

  void undoDeletion() {
    emit(state.copyWith(quoteToDelete: null));
  }

  // Hides the quote right away and deletes it after a delay, so the user can
  // still undo it. A previously pending deletion is finished immediately.
  Future<void> deleteQuote({required QuoteModel quote}) async {
    if (state.quoteToDelete != null) {
      await _delete(state.quoteToDelete!);
    }
    emit(state.copyWith(quoteToDelete: quote));

    await Future.delayed(const Duration(seconds: 3));
    if (state.quoteToDelete?.uuid == quote.uuid) {
      await _delete(quote, shouldHandle: true);
    }
  }

  Future<void> _delete(QuoteModel quote, {bool shouldHandle = false}) async {
    final uuid = quote.uuid;
    if (uuid != null) {
      await _quotesRepository.deleteQuote(id: uuid, href: quote.href);
    }
    final quotes = List<QuoteModel>.from(state.quotes)
      ..removeWhere((e) => e.uuid == uuid);
    emit(state.copyWith(quotes: quotes));
    if (!shouldHandle) return;
    emit(state.copyWith(quoteToDelete: null));
  }

  // --------------------------
  // --------------------------
  // --------------------------

  Future<void> createQuote({
    required BookModel book,
    required String startElem,
    required String endElem,
    required int startOffset,
    required int endOffset,
    required String text,
  }) async {
    emit(state.copyWith(isLoading: true, isQuoteSuccess: null));
    final result = await _quotesRepository.createQuote(
      book: book,
      startElem: startElem,
      endElem: endElem,
      startOffset: startOffset,
      endOffset: endOffset,
      text: text,
    );
    result.handle(
      success: (_, __) {
        emit(
          state.copyWith(
            isLoading: false,
            isQuoteSuccess: (Success.create, true),
          ),
        );
      },
      failure: (_) {
        emit(
          state.copyWith(
            isLoading: false,
            isQuoteSuccess: (Success.create, false),
          ),
        );
      },
    );
  }
}
