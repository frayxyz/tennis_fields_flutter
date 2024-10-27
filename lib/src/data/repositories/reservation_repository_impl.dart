import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';
import 'package:tennis_booking/src/domain/gateways/reservation_repository.dart';

import '../services/db_helper.dart';

class ReservationRepositoryImpl implements ReservationRepository{
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<List<Reservation>> getUserReservations(int userId) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'Reservations',
      where: 'user_id = ? ',
      whereArgs: [userId],
    );
    debugPrint("result reservations by user ${result.toString()}");
    return result.map((data) => Reservation.fromMap(data)).toList();
  }

  @override
  Future<int> saveReservation(Reservation newReservation) async {
    final db = await _databaseHelper.database;
    try {
      return await db.insert(
        'Reservations',
        newReservation.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // Maneja el error según sea necesario
      print("Error al guardar la reserva: $e");
      throw Exception("Error al guardar la reserva");
    }
  }

  @override
  Future<void> rescheduleReservation(Reservation reservationUpdate) {
    // TODO: implement rescheduleReservation
    throw UnimplementedError();
  }

  @override
  Future<List<Reservation>> getReservationsByFieldAndDate(int fieldId, String date) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'Reservations',
      where: 'field_id = ? AND date = ?',
      whereArgs: [fieldId, date],
    );
    debugPrint("result reservations by field ${result.toString()}");
    return result.map((data) => Reservation.fromMap(data)).toList();
  }

  @override
  Future<List<Reservation>> getReservationsByInstructorAndDate(int instructorId, String date) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'Reservations',
      where: 'instructor_id = ? AND date = ?',
      whereArgs: [instructorId, date],
    );
    debugPrint("result reservations by coach ${result.toString()}");
    return result.map((data) => Reservation.fromMap(data)).toList();
  }

  @override
  Future<void> deleteReservation(int userId, int idReservation) {
    // TODO: implement deleteReservation
    throw UnimplementedError();
  }
}