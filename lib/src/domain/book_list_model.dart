import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_list_model.freezed.dart';
part 'book_list_model.g.dart';

@freezed
sealed class BookListModel with _$BookListModel {
  const factory BookListModel({
    required String name,
    required String slug,
    required List<String> books,
  }) = _BookListModel;

  factory BookListModel.fromJson(Map<String, dynamic> json) =>
      _$BookListModelFromJson(json);
}
