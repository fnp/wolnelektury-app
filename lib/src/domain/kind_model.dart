import 'package:freezed_annotation/freezed_annotation.dart';

part 'kind_model.freezed.dart';
part 'kind_model.g.dart';

@freezed
class KindModel with _$KindModel {
  const factory KindModel({
    String? url,
    String? name,
    String? href,
    String? slug,
  }) = _KindModel;

  factory KindModel.fromJson(Map<String, dynamic> json) =>
      _$KindModelFromJson(json);
}
