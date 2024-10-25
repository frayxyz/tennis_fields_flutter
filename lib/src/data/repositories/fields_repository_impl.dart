import 'package:flutter/widgets.dart';
import 'package:tennis_booking/src/domain/entities/field.dart';
import 'package:tennis_booking/src/domain/gateways/fields_repository.dart';

import '../services/db_helper.dart';

class FieldsRepositoryImpl implements FieldRepository{

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<List<Field>> getFields() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Fields');
    debugPrint("fields en db: ${maps.toString()}");
    return maps.map((map) => Field.fromMap(map)).toList();
  }
}