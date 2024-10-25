import 'package:tennis_booking/src/core/usecase/usecase.dart';
import 'package:tennis_booking/src/domain/entities/user_info.dart';

import '../entities/user.dart';
import '../gateways/user_repository.dart';

class LoginUseCase implements UseCase<UserInfo?, LoginParams> {

  final UserRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserInfo?> execute(LoginParams params) async {
    User?  user = await repository.getUserByEmailAndPassWord(params.email, params.password);
    if(user != null){
      return UserInfo.fromUser(user);
    }
    return null;
  }
  
}

class LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}