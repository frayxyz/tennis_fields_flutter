import '../entities/user_info.dart';

abstract class InstructorRepository{
  Future<List<UserInfo>> getInstructors(String userType);
}