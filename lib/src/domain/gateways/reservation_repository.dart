
import 'package:tennis_booking/src/domain/entities/reservation.dart';

abstract class ReservationRepository{
  Future<List<Reservation>> getUserReservations(int userId);
  Future<int> saveReservation(Reservation newReservation);
  Future<void> rescheduleReservation(Reservation reservationUpdate);
  Future<void> deleteReservation(int userId, int idReservation);
  Future<List<Reservation>> getReservationsByFieldAndDate(int fieldId, String date);
  Future<List<Reservation>> getReservationsByInstructorAndDate(int instructorId, String date);
}