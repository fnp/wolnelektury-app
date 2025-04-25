import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.unauthorized() = _Unauthorized;
  const factory Failure.notFound() = _NotFound;
  const factory Failure.badResponse() = _BadResponse;
}
