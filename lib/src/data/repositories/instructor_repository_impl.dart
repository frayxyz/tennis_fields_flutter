import 'package:tennis_booking/src/domain/gateways/instructor_repository.dart';

import '../../domain/entities/user_info.dart';
import '../services/db_helper.dart';

class InstructorRepositoryImpl implements InstructorRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<List<UserInfo>> getInstructors(String userType) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> results = await db.query(
      'Users',
      columns: ['id', 'name'],
      where: 'user_type = ?',
      whereArgs: ['coach'],
    );

    if(results.isNotEmpty){
      return results.map((instructorJson)=>UserInfo.fromJson(instructorJson)).toList();
    }
    return [];
  }
}