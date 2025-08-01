import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'bookmark_model.freezed.dart';
part 'bookmark_model.g.dart';

@freezed
sealed class BookmarkModel with _$BookmarkModel {
  const factory BookmarkModel({
    required String location,
    @JsonKey(name: 'book') required String slug,
    required String note,
    required String anchor,
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
    required String anchor,
    String? note,
  }) {
    return BookmarkModel(
      location: '$slug/$anchor',
      slug: slug,
      note: note ?? '',
      anchor: anchor,
      href: '',
    );
  }
}
