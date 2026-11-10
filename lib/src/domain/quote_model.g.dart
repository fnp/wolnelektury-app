// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteModel _$QuoteModelFromJson(Map<String, dynamic> json) => _QuoteModel(
  uuid: json['uuid'] as String?,
  text: json['text'] as String? ?? '',
  book: BookModel.fromJson(json['book'] as Map<String, dynamic>),
  bookSlug: json['book_slug'] as String?,
  startElem: json['start_elem'] as String?,
  endElem: json['end_elem'] as String?,
  startOffset: (json['start_offset'] as num?)?.toInt(),
  endOffset: (json['end_offset'] as num?)?.toInt(),
  href: json['href'] as String,
  timestamp: (json['timestamp'] as num?)?.toInt(),
  deleted: json['deleted'] as bool? ?? false,
);

Map<String, dynamic> _$QuoteModelToJson(_QuoteModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'text': instance.text,
      'book': instance.book,
      'book_slug': instance.bookSlug,
      'start_elem': instance.startElem,
      'end_elem': instance.endElem,
      'start_offset': instance.startOffset,
      'end_offset': instance.endOffset,
      'href': instance.href,
      'timestamp': instance.timestamp,
      'deleted': instance.deleted,
    };
