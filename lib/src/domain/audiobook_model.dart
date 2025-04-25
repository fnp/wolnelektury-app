import 'package:freezed_annotation/freezed_annotation.dart';

part 'audiobook_model.freezed.dart';
part 'audiobook_model.g.dart';

@freezed
class AudiobookModel with _$AudiobookModel {
  const factory AudiobookModel({
    @Default([]) List<AudioBookPart> parts,
  }) = _AudiobookModel;

  factory AudiobookModel.fromJson(Map<String, dynamic> json) =>
      _$AudiobookModelFromJson(json);

  factory AudiobookModel.create({
    required List<AudioBookPart> parts,
  }) =>
      AudiobookModel(
        parts: parts,
      );
}

@freezed
class AudioBookPart with _$AudioBookPart {
  const factory AudioBookPart({
    required String name,
    required String artist,
    required String director,
    required String url,
    required double duration,
    required int size,
  }) = _AudioBookPart;

  factory AudioBookPart.fromJson(Map<String, dynamic> json) =>
      _$AudioBookPartFromJson(json);
}
