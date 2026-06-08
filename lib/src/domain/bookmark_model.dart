import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/book_model.dart';

part 'bookmark_model.freezed.dart';
part 'bookmark_model.g.dart';

@freezed
sealed class BookmarkModel with _$BookmarkModel {
  const factory BookmarkModel({
    String? uuid,
    required String location,
    required BookModel book,
    @JsonKey(name: 'book_slug') String? bookSlug,
    @JsonKey(name: 'audio_timestamp') int? audioTimestamp,
    String? anchor,
    required String note,
    required String href,

    // This field is optional and used for syncing purposes.
    int? timestamp,
    @Default(false) bool isDeleted,
  }) = _BookmarkModel;

  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);

  factory BookmarkModel.skeletonized() {
    return BookmarkModel(
      location: BoneMock.name,
      bookSlug: BoneMock.name,
      note: BoneMock.name,
      anchor: BoneMock.name,
      href: BoneMock.name,
      book: BookModel.skeletonized(),
    );
  }

  factory BookmarkModel.withLocation({
    required BookModel book,
    String? anchor,
    int? audioTimestamp,
    String? note,
  }) {
    assert(
      (anchor != null) ^ (audioTimestamp != null),
      'Either anchor or audioTimestamp must be provided, but not both',
    );
    final location = anchor != null
        ? '${book.slug}/$anchor'
        : '${book.slug}/audio/$audioTimestamp';

    return BookmarkModel(
      location: location,
      audioTimestamp: audioTimestamp,
      book: book,
      bookSlug: book.slug,
      note: note ?? '',
      anchor: anchor,
      href: '',
    );
  }
}
