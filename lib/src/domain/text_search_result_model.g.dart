// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TextSearchResultModel _$TextSearchResultModelFromJson(
  Map<String, dynamic> json,
) => _TextSearchResultModel(
  book: BookModel.fromJson(json['book'] as Map<String, dynamic>),
  snippets:
      (json['snippets'] as List<dynamic>?)
          ?.map((e) => BookSnippetModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TextSearchResultModelToJson(
  _TextSearchResultModel instance,
) => <String, dynamic>{'book': instance.book, 'snippets': instance.snippets};

_BookSnippetModel _$BookSnippetModelFromJson(Map<String, dynamic> json) =>
    _BookSnippetModel(
      anchor: json['anchor'] as String,
      headline: json['headline'] as String,
    );

Map<String, dynamic> _$BookSnippetModelToJson(_BookSnippetModel instance) =>
    <String, dynamic>{'anchor': instance.anchor, 'headline': instance.headline};
