import 'package:flutter/material.dart';
import 'package:tennis_booking/src/domain/entities/user_info.dart';

import '../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../gateways/user_repository.dart';

class SignUpUseCase implements UseCase<UserInfo?, User>{

  final UserRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<UserInfo?> execute(User params) async {

    try{
      String signupDate = DateTime.now().toString();
      debugPrint("Creando user con fecha $signupDate");
      int userId = await repository.addUser(params.name, params.email, params.password, params.phone, signupDate);
      return UserInfo(id: userId, email: params.email, name: params.name);

    }catch(e){
      debugPrint("Error creating user $e");
      return null;
    }

  }
}
