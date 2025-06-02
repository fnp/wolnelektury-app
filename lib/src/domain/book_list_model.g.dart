// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookListModelImpl _$$BookListModelImplFromJson(Map<String, dynamic> json) =>
    _$BookListModelImpl(
      name: json['name'] as String,
      slug: json['slug'] as String,
      books: (json['books'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$BookListModelImplToJson(_$BookListModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'books': instance.books,
    };
