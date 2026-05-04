import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';

part 'list_model.freezed.dart';
part 'list_model.g.dart';

@freezed
sealed class ListModel with _$ListModel {
  const factory ListModel({
    required String name,
    required String slug,
    @Default([]) List<ListItemModel> items,
  }) = _BookListModel;

  factory ListModel.fromJson(Map<String, dynamic> json) =>
      _$BookListModelFromJson(json);

  factory ListModel.skeletonized() {
    return ListModel(name: BoneMock.title, slug: '', items: []);
  }

  factory ListModel.empty() {
    return const ListModel(name: '', slug: '', items: []);
  }
}

@freezed
sealed class ListItemModel with _$ListItemModel {
  const factory ListItemModel({
    String? uuid,
    @JsonKey(name: 'list_slug') required String listSlug,
    int? order,
    int? timestamp,
    @Default(false) bool favorites,
    @Default(false) bool deleted,
    BookModel? book,
    BookmarkModel? bookmark,
    // String? fragment,
    // String? quote,
    @Default('') String note,
  }) = _ListItemModel;

  factory ListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ListItemModelFromJson(json);

  /// Factory method for creating a book list item
  factory ListItemModel.create({
    required String listSlug,
    String? bookSlug,
    String? bookmarkUuid,
    String? uuid,
    String note = '',
  }) => ListItemModel(
    listSlug: listSlug,
    book: bookSlug != null
        ? BookModel(title: '', slug: bookSlug, url: '')
        : null,
    bookmark: bookmarkUuid != null
        ? BookmarkModel(
            uuid: bookmarkUuid,
            location: '',
            slug: '',
            note: '',
            href: '',
          )
        : null,
    uuid: uuid,
    note: note,
  );
}

extension ListItemModelX on ListItemModel {
  bool get isBook => book != null;
  bool get isBookmark => bookmark != null;

  /// Returns the identifier (slug) of this item, whether it's a book or bookmark
  String? get itemIdentifier => book?.slug ?? bookmark?.uuid;

  Map<String, dynamic> toCleanJson() {
    final json = <String, dynamic>{};

    // Add book slug if book exists
    if (book != null) {
      json['book_slug'] = book!.slug;
    }

    // Add bookmark uuid if bookmark exists
    if (bookmark != null) {
      json['bookmark'] = bookmark!.uuid;
    }

    // Add note
    json['note'] = note;

    return json;
  }
}
