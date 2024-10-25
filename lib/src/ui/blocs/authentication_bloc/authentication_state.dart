part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthStatus status;
  final UserInfo?  userInfo;
  final String? error;

  const AuthenticationState(this.status,{this.userInfo, this.error});

  @override
  List<Object?> get props => [status, userInfo, error];
}

enum AuthStatus{
  initial,
  authenticated,
  unauthenticated,
  registerSuccess,
  loading
}
