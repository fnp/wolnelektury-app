// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OfflineBookModel _$OfflineBookModelFromJson(Map<String, dynamic> json) =>
    _OfflineBookModel(
      book: BookModel.fromJson(json['book'] as Map<String, dynamic>),
      isAudiobookCorrectlyDownloaded:
          json['isAudiobookCorrectlyDownloaded'] as bool? ?? false,
      audiobook: json['audiobook'] == null
          ? null
          : AudiobookModel.fromJson(json['audiobook'] as Map<String, dynamic>),
      reader: json['reader'] == null
          ? null
          : ReaderBookModel.fromJson(json['reader'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfflineBookModelToJson(_OfflineBookModel instance) =>
    <String, dynamic>{
      'book': instance.book,
      'isAudiobookCorrectlyDownloaded': instance.isAudiobookCorrectlyDownloaded,
      'audiobook': instance.audiobook,
      'reader': instance.reader,
    };
