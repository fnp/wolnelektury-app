import 'package:freezed_annotation/freezed_annotation.dart';

part 'audiobook_model.freezed.dart';
part 'audiobook_model.g.dart';

@freezed
sealed class AudiobookModel with _$AudiobookModel {
  const factory AudiobookModel({@Default([]) List<AudioBookPart> parts}) =
      _AudiobookModel;

  factory AudiobookModel.fromJson(Map<String, dynamic> json) =>
      _$AudiobookModelFromJson(json);

  factory AudiobookModel.create({required List<AudioBookPart> parts}) =>
      AudiobookModel(parts: parts);
}

extension AudiobookModelX on AudiobookModel {
  double get totalSizeInMB =>
      parts.fold(0.0, (total, part) => total + part.size / 1024 / 1024);
}

@freezed
sealed class AudioBookPart with _$AudioBookPart {
  const factory AudioBookPart({
    required String name,
    required String artist,
    required String director,
    required String type,
    // Either a URL to the audio file or a path to a local file
    required String url,
    required double duration,
    required int size,
    @Default(false) bool isOffline,
  }) = _AudioBookPart;

  factory AudioBookPart.fromJson(Map<String, dynamic> json) =>
      _$AudioBookPartFromJson(json);
}
