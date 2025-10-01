import 'package:freezed_annotation/freezed_annotation.dart';

part 'epoch_model.freezed.dart';
part 'epoch_model.g.dart';

@freezed
sealed class EpochModel with _$EpochModel {
  const factory EpochModel({
    int? id,
    String? url,
    String? name,
    String? href,
    String? slug,
  }) = _EpochModel;

  factory EpochModel.fromJson(Map<String, dynamic> json) =>
      _$EpochModelFromJson(json);
}
