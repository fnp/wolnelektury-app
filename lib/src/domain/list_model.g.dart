// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookListModel _$BookListModelFromJson(Map<String, dynamic> json) =>
    _BookListModel(
      name: json['name'] as String,
      slug: json['slug'] as String,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BookListModelToJson(_BookListModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'items': instance.items,
    };

_ListItemModel _$ListItemModelFromJson(Map<String, dynamic> json) =>
    _ListItemModel(
      uuid: json['uuid'] as String?,
      listSlug: json['list_slug'] as String,
      order: (json['order'] as num?)?.toInt(),
      timestamp: (json['timestamp'] as num?)?.toInt(),
      favorites: json['favorites'] as bool? ?? false,
      deleted: json['deleted'] as bool? ?? false,
      bookSlug: json['book_slug'] as String?,
      fragment: json['fragment'] as String?,
      quote: json['quote'] as String?,
      bookmark: json['bookmark'] as String?,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$ListItemModelToJson(_ListItemModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'list_slug': instance.listSlug,
      'order': instance.order,
      'timestamp': instance.timestamp,
      'favorites': instance.favorites,
      'deleted': instance.deleted,
      'book_slug': instance.bookSlug,
      'fragment': instance.fragment,
      'quote': instance.quote,
      'bookmark': instance.bookmark,
      'note': instance.note,
    };
