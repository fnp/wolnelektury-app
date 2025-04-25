// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponsePaginationImpl _$$ApiResponsePaginationImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiResponsePaginationImpl(
      first: json['first'] as String?,
      last: json['last'] as String?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$$ApiResponsePaginationImplToJson(
        _$ApiResponsePaginationImpl instance) =>
    <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'next': instance.next,
      'previous': instance.previous,
    };
