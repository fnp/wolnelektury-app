import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_model.freezed.dart';
part 'progress_model.g.dart';

@freezed
class ProgressModel with _$ProgressModel {
  const factory ProgressModel({
    String? book,
    String? slug,
    @JsonKey(name: 'last_mode') String? lastMode,
    @JsonKey(name: 'text_percent') double? textPercent,
    @JsonKey(name: 'text_anchor') String? textAnchor,
    @JsonKey(name: 'audio_percent') double? audioPercent,
    @JsonKey(name: 'audio_timestamp') double? audioTimestamp,
    @JsonKey(name: 'implicit_text_percent') double? implicitTextPercent,
    @JsonKey(name: 'implicit_text_anchor') String? implicitTextAnchor,
    @JsonKey(name: 'implicit_audio_percent') double? implicitAudioPercent,
    @JsonKey(name: 'implicit_audio_timestamp') double? implicitAudioTimestamp,
  }) = _ProgressModel;

  factory ProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressModelFromJson(json);
}

@freezed
class TextProgressModel with _$TextProgressModel {
  const factory TextProgressModel({
    @JsonKey(name: 'text_percent') double? textPercent,
    @JsonKey(name: 'text_anchor') String? textAnchor,
  }) = _TextProgressModel;

  factory TextProgressModel.fromJson(Map<String, dynamic> json) =>
      _$TextProgressModelFromJson(json);
}

@freezed
class AudioProgressModel with _$AudioProgressModel {
  const factory AudioProgressModel({
    @JsonKey(name: 'audio_timestamp') int? audioTimestamp,
    @JsonKey(name: 'audio_percent') double? audioPercent,
  }) = _AudioProgressModel;

  factory AudioProgressModel.fromJson(Map<String, dynamic> json) =>
      _$AudioProgressModelFromJson(json);
}
