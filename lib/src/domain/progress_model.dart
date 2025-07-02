import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_model.freezed.dart';
part 'progress_model.g.dart';

@freezed
sealed class ProgressModel with _$ProgressModel {
  const factory ProgressModel({
    @JsonKey(name: 'book_slug') String? slug,
    @JsonKey(name: 'text_anchor') String? textAnchor,
    @JsonKey(name: 'audio_timestamp') int? audioTimestamp,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ProgressModel;

  factory ProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressModelFromJson(json);

  factory ProgressModel.fromAudio({
    required String slug,
    required int audioTimestamp,
  }) {
    return ProgressModel(
      slug: slug,
      audioTimestamp: audioTimestamp,
      textAnchor: null,
      updatedAt: DateTime.now(),
    );
  }

  factory ProgressModel.fromText({
    required String slug,
    required String textAnchor,
  }) {
    return ProgressModel(
      slug: slug,
      audioTimestamp: null,
      textAnchor: textAnchor,
      updatedAt: DateTime.now(),
    );
  }
}
