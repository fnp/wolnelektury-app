part of 'single_book_cubit.dart';

@freezed
class SingleBookState with _$SingleBookState {
  const factory SingleBookState({
    @Default(false) bool isLoading,
    BookModel? book,
  }) = _SingleBookState;
}
