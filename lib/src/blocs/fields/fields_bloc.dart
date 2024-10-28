
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:tennis_booking/src/data/repositories/reservation_repository_impl.dart';
import 'package:tennis_booking/src/domain/entities/field_availability/field_availability.dart';
import 'package:tennis_booking/src/domain/usecases/get_fields_with_available_date_usecase.dart';

import '../../domain/entities/field.dart';
import '../../domain/gateways/fields_repository.dart';
import '../../domain/gateways/reservation_repository.dart';

part 'fields_event.dart';
part 'fields_state.dart';

class FieldsBloc extends Bloc<FieldsEvent, FieldsState> {
  final FieldRepository repository;
  final ReservationRepository reservationRepository = ReservationRepositoryImpl();

  FieldsBloc(this.repository) : super(FieldsInitial()) {
    on<FieldsEvent>((event, emit) async {
      if(event is LoadFieldsEvent){
        debugPrint("loading fields");
        List<Field> fields = await repository.getFields();
        emit(FieldsLoaded(fields));
      }else if(event is LoadFieldsWithAvailability){
        try {
          debugPrint("loading fields with availability");
          emit(FieldsLoading());
          final useCase = CheckNextAvailableCourtDateUseCase(repository, reservationRepository);
          final List<FieldAvailability> availability = await useCase.execute();
          debugPrint("resultado fields with availability ${availability.length} ${availability[0].field.name.toString()} ${availability[0].availableTimes.toString()}");
          emit(FieldsAvailabilityLoaded(availability));
        } catch (error) {
          debugPrint("Error loading fields with availability: $error");
          emit(const FieldsError("Error loading fields with availability"));
        }
      }
    });
  }

}
