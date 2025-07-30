import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';

part 'like_sync_model.freezed.dart';
part 'like_sync_model.g.dart';

@freezed
sealed class LikeSyncModel with _$LikeSyncModel {
  const factory LikeSyncModel({
    @JsonKey(name: 'book_slug') required String slug,
    @Default(false) bool deleted,
    @Default(true) bool favourite,
    int? timestamp,
  }) = _LikeSyncModel;

  factory LikeSyncModel.fromJson(Map<String, dynamic> json) =>
      _$LikeSyncModelFromJson(json);

  factory LikeSyncModel.fromLike({required Like like}) {
    return LikeSyncModel(
      slug: like.slug,
      deleted: !like.isLiked,
      timestamp: like.updatedAt.millisecondsSinceEpoch,
      favourite: true,
    );
  }
}
