part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingAgreements,
    bool? isLoginSuccess,
    bool? isRegisterSuccess,
    bool? isLoginSuccessFromRegisterFlow,
    UserModel? user,
    RegisterAgreementModel? agreements,
  }) = _AuthState;
}

extension AuthStateX on AuthState {
  bool get isAuthenticated => user != null;

  bool isAgreementChecked(int id) {
    return agreements?.options
            .firstWhere((element) => element.id == id)
            .isChecked ??
        false;
  }

  bool get areAllRequiredAgreementsChecked {
    return agreements?.options.every((element) {
          if (!element.required) return true;
          return element.isChecked;
        }) ??
        false;
  }

  List<int> get getListOfAgreements {
    return agreements?.options
            .mapIndexed((index, option) {
              if (option.isChecked) {
                return index + 1;
              }
              return null;
            })
            .whereType<int>()
            .toList() ??
        [];
  }
}
