part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitialState extends LoginState {
  const LoginInitialState();

  @override
  List<Object> get props => [];
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState({this.provider});

  final SocialProvider? provider;

  @override
  List<Object?> get props => [provider];
}

final class LoginSuccessState extends LoginState {
  const LoginSuccessState();

  @override
  List<Object> get props => [];
}

final class LoginFailureState extends LoginState {
  const LoginFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
