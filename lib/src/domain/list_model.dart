import 'package:freezed_annotation/freezed_annotation.dart';

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
    @JsonKey(name: 'book_slug') String? bookSlug,
    String? fragment,
    String? quote,
    String? bookmark,
    @Default('') String note,
  }) = _ListItemModel;

  factory ListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ListItemModelFromJson(json);
}

enum ListType { books, bookmarks }

extension ListItemModelX on ListItemModel {
  bool get isBook => bookSlug != null;
  bool get isBookmark => bookmark != null;

  Map<String, dynamic> toCleanJson() {
    return toJson()
      ..remove('uuid')
      ..remove('list_slug')
      ..remove('order')
      ..remove('timestamp')
      ..remove('order')
      ..remove('deleted');
  }
}
