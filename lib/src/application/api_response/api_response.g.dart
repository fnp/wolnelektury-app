// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponsePagination _$ApiResponsePaginationFromJson(
  Map<String, dynamic> json,
) => _ApiResponsePagination(
  first: json['first'] as String?,
  last: json['last'] as String?,
  next: json['next'] as String?,
  previous: json['previous'] as String?,
);

Map<String, dynamic> _$ApiResponsePaginationToJson(
  _ApiResponsePagination instance,
) => <String, dynamic>{
  'first': instance.first,
  'last': instance.last,
  'next': instance.next,
  'previous': instance.previous,
};
