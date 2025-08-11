import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/domain/book_model.dart';

part 'text_search_result_model.freezed.dart';
part 'text_search_result_model.g.dart';

@freezed
sealed class TextSearchResultModel with _$TextSearchResultModel {
  const factory TextSearchResultModel({
    required BookModel book,
    @Default([]) List<BookSnippetModel> snippets,
  }) = _TextSearchResultModel;

  factory TextSearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$TextSearchResultModelFromJson(json);
}

@freezed
sealed class BookSnippetModel with _$BookSnippetModel {
  const factory BookSnippetModel({
    required String anchor,
    required String headline,
  }) = _BookSnippetModel;

  factory BookSnippetModel.fromJson(Map<String, dynamic> json) =>
      _$BookSnippetModelFromJson(json);
}
