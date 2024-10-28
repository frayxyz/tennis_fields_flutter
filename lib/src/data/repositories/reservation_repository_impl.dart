import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';
import 'package:tennis_booking/src/domain/gateways/reservation_repository.dart';
import 'package:tennis_booking/src/utils/date_helper.dart';

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
      debugPrint("Error al guardar la reserva: $e");
      throw Exception("Error al guardar la reserva");
    }
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
  Future<void> deleteReservation(int idReservation) async {
    final db = await _databaseHelper.database;

    await db.delete(
      'Reservations',
      where: 'id = ?',
      whereArgs: [idReservation],
    );
  }

  @override
  Future<String?> getNextAvailableDate(int fieldId) async {
    final db = await _databaseHelper.database;

    DateTime currentDate = DateTime.now();

    for (int i = 1; i <= 30; i++) {
      DateTime checkDate = currentDate.add(Duration(days: i));
      String formattedDate = DateHelper.formatDateToString(checkDate);

      final reservationCount = await db.query(
        'Reservations',
        where: 'field_id = ? AND reservation_date = ?',
        whereArgs: [fieldId, formattedDate],
      );

      if (reservationCount.length < 3) {
        return formattedDate;
      }
    }

    return null;
  }


  @override
  Future<List<String>> getAvailableTimes(int fieldId, String reservationDate) async {
    final db = await _databaseHelper.database;

    final List<String> allTimes = List.generate(11, (index) => '${index + 7}:00'); // Horas desde las 7:00 hasta las 17:00
    final List<String> reservedTimes = [];

    final reservations = await db.query(
      'Reservations',
      where: 'field_id = ? AND reservation_date = ?',
      whereArgs: [fieldId, reservationDate],
    );

    debugPrint("reservations $reservationDate  $fieldId bd : ${reservations.toString()}");
    for (var reservation in reservations) {
      reservedTimes.add(reservation['start_time'] as String);
    }

    return allTimes.where((time) => !reservedTimes.contains(time)).toList();
  }

  @override
  Future<int> getReservationCountByFieldAndDate(int fieldId, DateTime date) async {
    final db = await _databaseHelper.database;
    try {
      String formattedDate = DateHelper.formatDateToString(date);

      final reservationCount = await db.query(
        'Reservations',
        where: 'field_id = ? AND reservation_date = ?',
        whereArgs: [fieldId, formattedDate],
      );
      return reservationCount.length;
    } catch (e) {
      debugPrint('Error al consultar reservas: $e');
      return 0;
    }
  }

}