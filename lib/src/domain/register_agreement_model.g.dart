// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_agreement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterAgreementModel _$RegisterAgreementModelFromJson(
  Map<String, dynamic> json,
) => _RegisterAgreementModel(
  info:
      (json['info'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  options:
      (json['options'] as List<dynamic>?)
          ?.map(
            (e) => SingleRegisterAgreementModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$RegisterAgreementModelToJson(
  _RegisterAgreementModel instance,
) => <String, dynamic>{'info': instance.info, 'options': instance.options};

_SingleRegisterAgreementModel _$SingleRegisterAgreementModelFromJson(
  Map<String, dynamic> json,
) => _SingleRegisterAgreementModel(
  id: (json['id'] as num).toInt(),
  html: json['html'] as String,
  required: json['required'] as bool,
  isChecked: json['isChecked'] as bool? ?? false,
);

Map<String, dynamic> _$SingleRegisterAgreementModelToJson(
  _SingleRegisterAgreementModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'html': instance.html,
  'required': instance.required,
  'isChecked': instance.isChecked,
};
