// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_agreement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterAgreementModelImpl _$$RegisterAgreementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterAgreementModelImpl(
      info:
          (json['info'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => SingleRegisterAgreementModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RegisterAgreementModelImplToJson(
        _$RegisterAgreementModelImpl instance) =>
    <String, dynamic>{
      'info': instance.info,
      'options': instance.options,
    };

_$SingleRegisterAgreementModelImpl _$$SingleRegisterAgreementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SingleRegisterAgreementModelImpl(
      id: (json['id'] as num).toInt(),
      html: json['html'] as String,
      required: json['required'] as bool,
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$$SingleRegisterAgreementModelImplToJson(
        _$SingleRegisterAgreementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'html': instance.html,
      'required': instance.required,
      'isChecked': instance.isChecked,
    };
