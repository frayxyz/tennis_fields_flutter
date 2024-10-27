
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/user.dart';
import '../../domain/entities/user_info.dart';
import '../../domain/gateways/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository repository;

  AuthenticationBloc({required this.repository}) : super(const AuthenticationState(AuthStatus.initial)) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoginEvent) {

        emit(const AuthenticationState(AuthStatus.loading));
        User?  user = await repository.getUserByEmailAndPassWord(event.email, event.password);
        if (user != null) {
          emit(AuthenticationState(AuthStatus.authenticated, userInfo: UserInfo.fromUser(user)));
        } else {
          emit(const AuthenticationState(AuthStatus.unauthenticated,
              error: 'Login failed'));
        }
      } else if (event is SignUpEvent) {

        String signupDate = DateTime.now().toString();
        emit(const AuthenticationState(AuthStatus.loading));
        try {
          int userId = await repository.addUser(event.name, event.email, event.password, event.phone, signupDate);

          emit(AuthenticationState(AuthStatus.registerSuccess, userInfo: UserInfo(email: event.email, name: event.name, id: userId))); // You can manage states accordingly
        }catch(e){
          debugPrint("error signup $e");
          emit(const AuthenticationState(AuthStatus.unauthenticated, error: "error signup"));
        }

      } else if (event is LogoutEvent) {}
    });
  }
}
