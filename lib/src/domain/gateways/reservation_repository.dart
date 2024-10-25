
import 'package:tennis_booking/src/domain/entities/reservation.dart';

abstract class ReservationRepository{
  Future<List<Reservation>> getUserReservations(String userId);
  Future<int> makeReservation(Reservation newReservation);
  Future<bool> rescheduleReservation(Reservation reservationUpdate);
}