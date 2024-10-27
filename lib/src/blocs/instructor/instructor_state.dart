part of 'instructor_bloc.dart';

abstract class InstructorState extends Equatable {
  const InstructorState();
  @override
  List<Object> get props => [];
}

class InstructorInitial extends InstructorState {}

class InstructorLoading extends InstructorState {}

class InstructorsLoaded extends InstructorState {
  final List<UserInfo> instructors;
  const InstructorsLoaded(this.instructors);
  @override
  List<Object> get props => [instructors];

  UserInfo? getInstructorById(int instructorId)=> instructors.where((i)=>i.id == instructorId).firstOrNull;
}

class InstructorError extends InstructorState {
  final String message;
  const InstructorError(this.message);
}