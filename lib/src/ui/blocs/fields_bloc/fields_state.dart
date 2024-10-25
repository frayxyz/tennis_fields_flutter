part of 'fields_bloc.dart';

abstract class FieldsState extends Equatable {
  const FieldsState();
}

class FieldsInitial extends FieldsState {
  @override
  List<Object> get props => [];
}

class FieldsLoaded extends FieldsState {
  final List<Field> fields;

  const FieldsLoaded(this.fields);
  @override
  List<Object> get props => [fields];
}