import 'package:flutter_test/flutter_test.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_editor/list_editor_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

class _FakeListsRepository extends Fake implements ListsRepository {
  String? addedTo;
  List<ListItemModel> added = [];

  @override
  Future<DataState<void>> addItemsToList({
    required String listSlug,
    required List<ListItemModel> items,
  }) async {
    addedTo = listSlug;
    added = items;
    return const DataState.success(data: null);
  }
}

void main() {
  late _FakeListsRepository repository;
  late ListEditorCubit cubit;

  setUp(() {
    repository = _FakeListsRepository();
    cubit = ListEditorCubit(repository);
    cubit.setListToEdit(
      const ListModel(name: 'My list', slug: 'my-list', items: []),
    );
  });

  tearDown(() => cubit.close());

  test('selecting a quote queues it and marks it as selected', () {
    cubit.addElement(quoteUuid: 'q1');

    expect(cubit.state.itemsToAdd.single.quote?.uuid, 'q1');
    expect(cubit.state.isItemInEditedList('q1'), isTrue);
    expect(cubit.state.numberOfChangesInEditedList, 1);
  });

  test('deselecting a quote cancels the pending addition', () {
    cubit.addElement(quoteUuid: 'q1');
    cubit.removeElement(quoteUuid: 'q1');

    expect(cubit.state.itemsToAdd, isEmpty);
    expect(cubit.state.itemsToRemove, isEmpty);
    expect(cubit.state.isItemInEditedList('q1'), isFalse);
  });

  test('saving sends the quote uuid to the list', () async {
    cubit.addElement(quoteUuid: 'q1');
    await cubit.saveList();

    expect(repository.addedTo, 'my-list');
    expect(repository.added.single.toCleanJson()['quote'], 'q1');
    expect(cubit.state.isSavingSuccess, isTrue);
  });

  test(
    'removing a quote that is already in the list queues its item',
    () async {
      final list = ListModel(
        name: 'My list',
        slug: 'my-list',
        items: [
          ListItemModel(
            uuid: 'item-1',
            listSlug: 'my-list',
            quote: QuoteModel(
              uuid: 'q1',
              book: BookModel.empty(slug: 'book'),
              href: '',
            ),
          ),
        ],
      );
      await cubit.setListToEdit(list);

      cubit.removeElement(quoteUuid: 'q1');

      expect(cubit.state.itemsToRemove.single.uuid, 'item-1');
      expect(cubit.state.isItemInEditedList('q1'), isFalse);
    },
  );

  test('only quotes known by the server can be added to lists', () {
    final book = BookModel.empty(slug: 'book');
    expect(QuoteModel(uuid: 'server', book: book, href: '').isSynced, isTrue);
    expect(
      QuoteModel(uuid: '${localQuoteIdPrefix}1', book: book, href: '').isSynced,
      isFalse,
    );
    expect(QuoteModel(book: book, href: '').isSynced, isFalse);
  });
}
