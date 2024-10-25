import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/field.dart';
import '../../../domain/gateways/fields_repository.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final FieldRepository repository;

  ReservationBloc(this.repository) : super(ReservationInitial()) {
    on<ReservationEvent>((event, emit) async {
      if(event is LoadFieldsEvent){
       List<Field> fields = await repository.getFields();
      }
    });
  }
}
