import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_agreement_model.freezed.dart';
part 'register_agreement_model.g.dart';

@freezed
sealed class RegisterAgreementModel with _$RegisterAgreementModel {
  const factory RegisterAgreementModel({
    @Default([]) List<String> info,
    @Default([]) List<SingleRegisterAgreementModel> options,
  }) = _RegisterAgreementModel;

  factory RegisterAgreementModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterAgreementModelFromJson(json);
}

@freezed
sealed class SingleRegisterAgreementModel with _$SingleRegisterAgreementModel {
  const factory SingleRegisterAgreementModel({
    required int id,
    required String html,
    required bool required,
    @Default(false) bool isChecked,
  }) = _SingleRegisterAgreementModel;

  factory SingleRegisterAgreementModel.fromJson(Map<String, dynamic> json) =>
      _$SingleRegisterAgreementModelFromJson(json);
}
