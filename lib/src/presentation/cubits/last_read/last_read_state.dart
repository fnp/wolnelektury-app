part of 'last_read_cubit.dart';

@freezed
class LastReadState with _$LastReadState {
  const factory LastReadState({
    @Default(false) bool isLoading,
    BookModel? book,
  }) = _LastReadState;
}
