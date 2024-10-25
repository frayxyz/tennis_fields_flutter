part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent{
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthenticationEvent{
  final String name;
  final String email;
  final String phone;
  final String password;

  const SignUpEvent({required this.name, required this.email, required this.phone, required this.password});

  @override
  List<Object?> get props =>[];
}

class LogoutEvent extends AuthenticationEvent{
  @override
  List<Object?> get props => [];
}