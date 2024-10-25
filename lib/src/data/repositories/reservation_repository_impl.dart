import 'package:tennis_booking/src/domain/entities/reservation.dart';
import 'package:tennis_booking/src/domain/gateways/reservation_repository.dart';

class ReservationRepositoryImpl implements ReservationRepository{
  @override
  Future<List<Reservation>> getUserReservations(String userId) {
    // TODO: implement getUserReservations
    throw UnimplementedError();
  }

  @override
  Future<int> makeReservation(Reservation newReservation) {
    // TODO: implement makeReservation
    throw UnimplementedError();
  }

  @override
  Future<bool> rescheduleReservation(Reservation reservationUpdate) {
    // TODO: implement rescheduleReservation
    throw UnimplementedError();
  }
}