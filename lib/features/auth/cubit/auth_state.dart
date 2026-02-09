abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthGoogleErrorState extends AuthState {
  final String errorText;

  AuthGoogleErrorState({required this.errorText});
}

class AuthErrorState extends AuthState {
  String? errorText;
  AuthErrorState({this.errorText});
}

class AuthInitial extends AuthState {}

class AuthEmailError extends AuthState {
  final String message;
  AuthEmailError({required this.message});
}

class AuthEmailValid extends AuthState {}

class AuthPasswordValid extends AuthState {}

class AuthPasswordError extends AuthState {
  final String message;
  AuthPasswordError({required this.message});
}

class PasswordVisibilityState extends AuthState {
  final bool isPasswordObscure;

  PasswordVisibilityState({required this.isPasswordObscure});
}
