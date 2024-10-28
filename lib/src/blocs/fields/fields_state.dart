part of 'fields_bloc.dart';

abstract class FieldsState extends Equatable {
  const FieldsState();
}

class FieldsInitial extends FieldsState {
  @override
  List<Object> get props => [];
}

class FieldsLoading extends FieldsState {
  @override
  List<Object> get props => [];
}

class FieldsLoaded extends FieldsState {
  final List<Field> fields;

  const FieldsLoaded(this.fields);
  @override
  List<Object> get props => [fields];
}

class FieldsAvailabilityLoaded extends FieldsState {
  final List<FieldAvailability> fields;

  const FieldsAvailabilityLoaded(this.fields);
  @override
  List<Object> get props => [fields];

  FieldAvailability? getFieldById(int fieldId) {
    return fields.where((f) => f.field.id! == fieldId).firstOrNull;
  }
}

class FieldsError extends FieldsState {
  final String message;

  const FieldsError(this.message);
  @override
  List<Object> get props => [message];
}
