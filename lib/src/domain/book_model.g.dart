// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookModel _$BookModelFromJson(Map<String, dynamic> json) => _BookModel(
  title: json['title'] as String,
  url: json['url'] as String,
  slug: json['slug'] as String,
  epochs:
      (json['epochs'] as List<dynamic>?)
          ?.map((e) => EpochModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  genres:
      (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  kinds:
      (json['kinds'] as List<dynamic>?)
          ?.map((e) => KindModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  authors:
      (json['authors'] as List<dynamic>?)
          ?.map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  translators:
      (json['translators'] as List<dynamic>?)
          ?.map((e) => BookTranslator.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  contentWarnings:
      (json['content_warnings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  audiences:
      (json['audiences'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  elevenReaderLink: json['elevenreader_link'] as String?,
  fragment: json['fragment_data'] == null
      ? null
      : BookFragmentData.fromJson(
          json['fragment_data'] as Map<String, dynamic>,
        ),
  simpleThumb: json['simple_thumb'] as String?,
  coverThumb: json['cover_thumb'] as String?,
  coverColor: json['cover_color'] as String?,
  coverUrl: json['cover'] as String?,
  simpleCoverUrl: json['simple_cover'] as String?,
  isbnPdf: json['isbn_pdf'] as String?,
  isbnEpub: json['isbn_epub'] as String?,
  isbnMobi: json['isbn_mobi'] as String?,
  description: json['abstract'] as String?,
  hasAudiobook: json['has_mp3_file'] as bool? ?? false,
);

Map<String, dynamic> _$BookModelToJson(_BookModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'slug': instance.slug,
      'epochs': instance.epochs,
      'genres': instance.genres,
      'kinds': instance.kinds,
      'authors': instance.authors,
      'translators': instance.translators,
      'content_warnings': instance.contentWarnings,
      'audiences': instance.audiences,
      'elevenreader_link': instance.elevenReaderLink,
      'fragment_data': instance.fragment,
      'simple_thumb': instance.simpleThumb,
      'cover_thumb': instance.coverThumb,
      'cover_color': instance.coverColor,
      'cover': instance.coverUrl,
      'simple_cover': instance.simpleCoverUrl,
      'isbn_pdf': instance.isbnPdf,
      'isbn_epub': instance.isbnEpub,
      'isbn_mobi': instance.isbnMobi,
      'abstract': instance.description,
      'has_mp3_file': instance.hasAudiobook,
    };

_BookFragmentData _$BookFragmentDataFromJson(Map<String, dynamic> json) =>
    _BookFragmentData(
      title: json['title'] as String?,
      html: json['html'] as String?,
    );

Map<String, dynamic> _$BookFragmentDataToJson(_BookFragmentData instance) =>
    <String, dynamic>{'title': instance.title, 'html': instance.html};

_BookTranslator _$BookTranslatorFromJson(Map<String, dynamic> json) =>
    _BookTranslator(name: json['name'] as String?);

Map<String, dynamic> _$BookTranslatorToJson(_BookTranslator instance) =>
    <String, dynamic>{'name': instance.name};
