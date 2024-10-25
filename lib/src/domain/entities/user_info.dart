import 'user.dart';

class UserInfo {
  final int? id;
  final String email;
  final String name;

  UserInfo({this.id, required this.email, required this.name});

  factory UserInfo.fromUser(User user) {
    return UserInfo(
      id: user.id,
      email: user.email,
      name: user.name
    );
  }
}