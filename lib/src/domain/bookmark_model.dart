import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'bookmark_model.freezed.dart';
part 'bookmark_model.g.dart';

@freezed
sealed class BookmarkModel with _$BookmarkModel {
  const factory BookmarkModel({
    @JsonKey(name: 'book') required String slug,
    required String note,
    required String anchor,
    required String href,
  }) = _BookmarkModel;

  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);

  factory BookmarkModel.skeletonized() {
    return BookmarkModel(
      slug: BoneMock.name,
      note: BoneMock.name,
      anchor: BoneMock.name,
      href: BoneMock.name,
    );
  }
}
