import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_text_audio_sync_model.freezed.dart';
part 'book_text_audio_sync_model.g.dart';

@freezed
sealed class BookTextAudioSyncModel with _$BookTextAudioSyncModel {
  const factory BookTextAudioSyncModel({
    required String id,
    required double timestamp,
  }) = _BookTextAudioSyncModel;

  factory BookTextAudioSyncModel.fromJson(Map<String, dynamic> json) =>
      _$BookTextAudioSyncModelFromJson(json);
}
