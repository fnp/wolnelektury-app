// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookListModel _$BookListModelFromJson(Map<String, dynamic> json) =>
    _BookListModel(
      name: json['name'] as String,
      slug: json['slug'] as String,
      books: (json['books'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BookListModelToJson(_BookListModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'books': instance.books,
    };
