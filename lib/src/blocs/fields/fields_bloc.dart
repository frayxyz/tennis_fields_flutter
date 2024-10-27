
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/field.dart';
import '../../domain/gateways/fields_repository.dart';

part 'fields_event.dart';
part 'fields_state.dart';

class FieldsBloc extends Bloc<FieldsEvent, FieldsState> {
  final FieldRepository repository;

  FieldsBloc(this.repository) : super(FieldsInitial()) {
    on<FieldsEvent>((event, emit) async {
      if(event is LoadFieldsEvent){
        debugPrint("loading fields");
        List<Field> fields = await repository.getFields();
        emit(FieldsLoaded(fields));
      }
    });
  }
}
