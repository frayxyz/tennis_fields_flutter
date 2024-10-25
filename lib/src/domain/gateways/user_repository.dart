import '../entities/user.dart';

abstract class UserRepository{
  Future<User?> getUserByEmailAndPassWord(String email, String password);
  Future<int> addUser(String name, String email, String password, String phone, String signupDate);
}