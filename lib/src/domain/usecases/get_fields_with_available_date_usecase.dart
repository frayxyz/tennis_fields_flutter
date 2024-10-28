

import 'package:tennis_booking/src/domain/entities/field_availability/field_availability.dart';

import '../entities/field.dart';
import '../gateways/fields_repository.dart';
import '../gateways/reservation_repository.dart';

class CheckNextAvailableCourtDateUseCase {
  final FieldRepository _fieldRepository;
  final ReservationRepository _reservationRepository;

  CheckNextAvailableCourtDateUseCase(this._fieldRepository, this._reservationRepository);

  Future<List<FieldAvailability>> execute() async {
    List<Field> fields = await _fieldRepository.getFields();
    List<FieldAvailability> fieldAvailabilityList = [];

    // Itera sobre los campos para verificar disponibilidad
    for (final field in fields) {
      // Obtiene la próxima fecha de disponibilidad para el campo
      final nextAvailableDate = await _reservationRepository.getNextAvailableDate(field.id!);

      if (nextAvailableDate != null) {
        final availableTimes = await _reservationRepository.getAvailableTimes(field.id!, nextAvailableDate);

        // Agrega la disponibilidad a la lista
        fieldAvailabilityList.add(FieldAvailability(
          field: field,
          nextAvailableDate: nextAvailableDate,
          availableTimes: availableTimes,
        ));
      }
    }

    return fieldAvailabilityList;
  }
}
