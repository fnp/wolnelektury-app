// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenericSearchResultModel _$GenericSearchResultModelFromJson(
  Map<String, dynamic> json,
) => _GenericSearchResultModel(
  author:
      (json['author'] as List<dynamic>?)
          ?.map((e) => DetailedAuthorModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  genre:
      (json['genre'] as List<dynamic>?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GenericSearchResultModelToJson(
  _GenericSearchResultModel instance,
) => <String, dynamic>{'author': instance.author, 'genre': instance.genre};
