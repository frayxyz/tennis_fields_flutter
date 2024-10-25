import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tennis_booking/src/domain/entities/user.dart';

import '../../domain/gateways/user_repository.dart';
import '../services/db_helper.dart';

class UserRepositoryImpl implements UserRepository {

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<User?> getUserByEmailAndPassWord(String email, String password) async {

    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'Users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    debugPrint("result from db is: ${result.toString()}");
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }

    return null; // user not found
  }


  @override
  Future<int> addUser(String name, String email, String password,String phone, String signupDate) async {
    final db = await _databaseHelper.database;
    return await db.insert(
      'Users',
      {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'signup_date': signupDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
