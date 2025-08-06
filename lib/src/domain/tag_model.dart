import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

@freezed
sealed class TagModel with _$TagModel {
  const factory TagModel({
    required int id,
    required String category,
    required String name,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  factory TagModel.fromId(int id, {String? category, String? name}) {
    return TagModel(id: id, category: category ?? '', name: name ?? '');
  }
}
