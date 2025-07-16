import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';

part 'sync_model.freezed.dart';
part 'sync_model.g.dart';

enum SyncType {
  progress,
  @JsonValue('user-list')
  userList,
}

@Freezed(unionKey: 'type')
sealed class SyncModel with _$SyncModel {
  @FreezedUnionValue('progress')
  const factory SyncModel.progress({
    required String id,
    required int timestamp,
    required SyncType type,
    required ProgressModel object,
  }) = SyncModelProgress;

  @FreezedUnionValue('user-list')
  const factory SyncModel.userList({
    required String id,
    required int timestamp,
    required SyncType type,
    //todo tu będzie np. model zakładki
    required dynamic object,
  }) = SyncModelUserList;

  //todo tu pewnie będa jeszcze polubione

  factory SyncModel.fromJson(Map<String, dynamic> json) =>
      _$SyncModelFromJson(json);
}
