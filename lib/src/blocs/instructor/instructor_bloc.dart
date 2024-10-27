
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_booking/src/domain/entities/user_info.dart';

import '../../domain/entities/enums/user_type.dart';
import '../../domain/gateways/instructor_repository.dart';

part 'instructor_event.dart';
part 'instructor_state.dart';

class InstructorBloc extends Bloc<InstructorEvent, InstructorState> {
  final InstructorRepository instructorRepository;

  InstructorBloc(this.instructorRepository) : super(InstructorInitial()) {
    on<InstructorEvent>((event, emit) async {
      if (event is FetchInstructors) {
        emit(InstructorLoading());
        try {
          List<UserInfo> instructors = await instructorRepository.getInstructors(UserType.coach.name);
          emit(InstructorsLoaded(instructors));
        } catch (e) {
          emit(const InstructorError("Failed to load instructors"));
        }
      }
    });
  }
}
