import 'package:flutter_test/flutter_test.dart';
import 'package:wolnelektury/src/data/quotes_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/enums/success_enum.dart';
import 'package:wolnelektury/src/features/readers/cubits/quotes/quotes_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

class _FakeQuotesRepository extends QuotesRepository {
  final List<QuoteModel> stored;
  final List<String> deletedIds = [];

  _FakeQuotesRepository(this.stored);

  @override
  Future<DataState<List<QuoteModel>>> getQuotes({
    int offset = 0,
    int limit = 20,
  }) async {
    final page = stored.skip(offset).take(limit).toList();
    if (page.isEmpty) return const DataState.failure(Failure.notFound());
    return DataState.success(data: page);
  }

  @override
  Future<DataState<void>> deleteQuote({
    required String id,
    required String href,
  }) async {
    deletedIds.add(id);
    stored.removeWhere((e) => e.uuid == id);
    return const DataState.success(data: null);
  }

  bool failCreate = false;

  @override
  Future<DataState<QuoteModel>> createQuote({
    required BookModel book,
    required String startElem,
    required String endElem,
    required int startOffset,
    required int endOffset,
    required String text,
  }) async {
    if (failCreate) return const DataState.failure(Failure.badResponse());
    return DataState.success(data: _quote('new'));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

QuoteModel _quote(String uuid) => QuoteModel(
  uuid: uuid,
  text: 'text $uuid',
  book: BookModel.empty(slug: 'book'),
  href: 'href/$uuid',
);

void main() {
  late _FakeQuotesRepository repository;
  late QuotesCubit cubit;

  setUp(() {
    repository = _FakeQuotesRepository(List.generate(25, (i) => _quote('q$i')));
    cubit = QuotesCubit(repository);
  });

  tearDown(() => cubit.close());

  test('loads first page and then the next one', () async {
    await cubit.getMyLibraryQuotes();
    expect(cubit.state.quotes.length, 20);
    expect(cubit.state.canLoadMore, isTrue);

    await cubit.getMoreMyLibraryQuotes();
    expect(cubit.state.quotes.length, 25);
    expect(cubit.state.canLoadMore, isFalse);
  });

  test('empty library results in empty list', () async {
    repository.stored.clear();
    await cubit.getMyLibraryQuotes();
    expect(cubit.state.quotes, isEmpty);
    expect(cubit.state.isLoading, isFalse);
  });

  test('undoing a deletion keeps the quote', () async {
    await cubit.getMyLibraryQuotes();
    final deletion = cubit.deleteQuote(quote: cubit.state.quotes.first);
    expect(cubit.state.quoteToDelete?.uuid, 'q0');

    cubit.undoDeletion();
    await deletion;

    expect(repository.deletedIds, isEmpty);
    expect(cubit.state.quoteExists('q0'), isTrue);
  });

  test('deletion is performed after the delay', () async {
    await cubit.getMyLibraryQuotes();
    await cubit.deleteQuote(quote: cubit.state.quotes.first);

    expect(repository.deletedIds, ['q0']);
    expect(cubit.state.quoteExists('q0'), isFalse);
    expect(cubit.state.quoteToDelete, isNull);
  });

  test('a new deletion finishes the pending one immediately', () async {
    await cubit.getMyLibraryQuotes();
    final first = cubit.deleteQuote(quote: cubit.state.quotes[0]);
    final second = cubit.deleteQuote(quote: cubit.state.quotes[1]);
    await Future.wait([first, second]);

    expect(repository.deletedIds, containsAll(['q0', 'q1']));
    expect(cubit.state.quotes.length, 18);
  });

  Future<void> create() => cubit.createQuote(
    book: BookModel.empty(slug: 'book'),
    startElem: 'a',
    endElem: 'b',
    startOffset: 0,
    endOffset: 1,
    text: 'x',
  );

  test('reports a successful creation for the snackbar', () async {
    await create();
    expect(cubit.state.isQuoteSuccess, (Success.create, true));
  });

  test('reports a failed creation for the snackbar', () async {
    repository.failCreate = true;
    await create();
    expect(cubit.state.isQuoteSuccess, (Success.create, false));
  });

  test('every creation emits a fresh result', () async {
    final results = <(Success, bool)?>[];
    final sub = cubit.stream.listen((s) => results.add(s.isQuoteSuccess));
    await create();
    await create();
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();

    expect(results.where((e) => e == (Success.create, true)), hasLength(2));
  });
}
