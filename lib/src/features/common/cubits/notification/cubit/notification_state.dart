part of 'notification_cubit.dart';

@freezed
sealed class NotificationState with _$NotificationState {
  const factory NotificationState({@Default(false) bool isLoading}) =
      _NotificationState;
}
