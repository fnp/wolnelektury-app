import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/author_model.dart';
import 'package:wolnelektury/src/domain/epoch_model.dart';
import 'package:wolnelektury/src/domain/genre_model.dart';
import 'package:wolnelektury/src/domain/kind_model.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
sealed class BookModel with _$BookModel {
  const factory BookModel({
    required String title,
    required String url,
    required String slug,
    @Default([]) List<EpochModel> epochs,
    @Default([]) List<GenreModel> genres,
    @Default([]) List<KindModel> kinds,
    @Default([]) List<AuthorModel> authors,
    @Default([]) List<BookTranslator> translators,
    @JsonKey(name: 'content_warnings')
    @Default([])
    List<String> contentWarnings,
    @Default([]) List<String> audiences,
    @JsonKey(name: 'elevenreader_link') String? elevenReaderLink,
    @JsonKey(name: 'fragment_data') BookFragmentData? fragment,
    @JsonKey(name: 'simple_thumb') String? simpleThumb,
    @JsonKey(name: 'cover_thumb') String? coverThumb,
    @JsonKey(name: 'cover_color') String? coverColor,
    @JsonKey(name: 'cover') String? coverUrl,
    @JsonKey(name: 'simple_cover') String? simpleCoverUrl,
    @JsonKey(name: 'isbn_pdf') String? isbnPdf,
    @JsonKey(name: 'isbn_epub') String? isbnEpub,
    @JsonKey(name: 'isbn_mobi') String? isbnMobi,
    @JsonKey(name: 'abstract') String? description,
    @JsonKey(name: 'has_mp3_file') @Default(false) bool hasAudiobook,
  }) = _BookModel;

  factory BookModel.empty() => BookModel(
    title: BoneMock.title,
    slug: '',
    authors: [AuthorModel(name: BoneMock.fullName, slug: '')],
    url: '',
    fragment: const BookFragmentData(
      title: '',
      html:
          'There is some long title, just for skeletonizor purposes. There is some long title, just for skeletonizor purposes. There is some long title, just for skeletonizor purposes.',
    ),
  );

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

@freezed
sealed class BookFragmentData with _$BookFragmentData {
  const factory BookFragmentData({String? title, String? html}) =
      _BookFragmentData;

  factory BookFragmentData.fromJson(Map<String, dynamic> json) =>
      _$BookFragmentDataFromJson(json);
}

@freezed
sealed class BookTranslator with _$BookTranslator {
  const factory BookTranslator({String? name}) = _BookTranslator;

  factory BookTranslator.fromJson(Map<String, dynamic> json) =>
      _$BookTranslatorFromJson(json);
}
