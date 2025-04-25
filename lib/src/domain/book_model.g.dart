// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      title: json['title'] as String,
      url: json['url'] as String,
      slug: json['slug'] as String,
      epochs: (json['epochs'] as List<dynamic>?)
              ?.map((e) => EpochModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      kinds: (json['kinds'] as List<dynamic>?)
              ?.map((e) => KindModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      translators: (json['translators'] as List<dynamic>?)
              ?.map((e) => BookTranslator.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fragment: json['fragment_data'] == null
          ? null
          : BookFragmentData.fromJson(
              json['fragment_data'] as Map<String, dynamic>),
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

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'slug': instance.slug,
      'epochs': instance.epochs,
      'genres': instance.genres,
      'kinds': instance.kinds,
      'authors': instance.authors,
      'translators': instance.translators,
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

_$BookFragmentDataImpl _$$BookFragmentDataImplFromJson(
        Map<String, dynamic> json) =>
    _$BookFragmentDataImpl(
      title: json['title'] as String?,
      html: json['html'] as String?,
    );

Map<String, dynamic> _$$BookFragmentDataImplToJson(
        _$BookFragmentDataImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'html': instance.html,
    };

_$BookTranslatorImpl _$$BookTranslatorImplFromJson(Map<String, dynamic> json) =>
    _$BookTranslatorImpl(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$BookTranslatorImplToJson(
        _$BookTranslatorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
