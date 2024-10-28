part of 'fields_bloc.dart';

abstract class FieldsEvent extends Equatable {
  const FieldsEvent();
}

class LoadFieldsEvent extends FieldsEvent{
  @override
  List<Object?> get props => [];
}

class LoadFieldsWithAvailability extends FieldsEvent{
  @override
  List<Object?> get props => [];
}