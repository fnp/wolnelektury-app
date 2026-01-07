import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/enums/hint_type_enum.dart';

part 'hint_model.freezed.dart';
part 'hint_model.g.dart';

@freezed
sealed class HintModel with _$HintModel {
  const factory HintModel({
    @JsonKey(unknownEnumValue: HintTypeEnum.unknown) required HintTypeEnum type,
    required String label,
    String? url,
    String? img,
    String? slug,
    int? id,
  }) = _HintModel;

  factory HintModel.fromJson(Map<String, dynamic> json) =>
      _$HintModelFromJson(json);
}
