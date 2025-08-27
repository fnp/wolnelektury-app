import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'bookmark_model.freezed.dart';
part 'bookmark_model.g.dart';

@freezed
sealed class BookmarkModel with _$BookmarkModel {
  const factory BookmarkModel({
    required String location,
    @JsonKey(name: 'book') required String slug,
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
      slug: BoneMock.name,
      note: BoneMock.name,
      anchor: BoneMock.name,
      href: BoneMock.name,
    );
  }

  factory BookmarkModel.withLocation({
    required String slug,
    String? anchor,
    int? audioTimestamp,
    String? note,
  }) {
    assert(
      (anchor != null) ^ (audioTimestamp != null),
      'Either anchor or audioTimestamp must be provided, but not both',
    );
    final location = anchor != null
        ? '$slug/$anchor'
        : '$slug/audio/$audioTimestamp';

    return BookmarkModel(
      location: location,
      audioTimestamp: audioTimestamp,
      slug: slug,
      note: note ?? '',
      anchor: anchor,
      href: '',
    );
  }
}
