import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/create_reservation/create_reservation_bloc.dart';
import '../../../../../blocs/instructor/instructor_bloc.dart';
import '../../../../../domain/entities/user_info.dart';

class InstructorSelect extends StatelessWidget {
  const InstructorSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructorBloc, InstructorState>(
      builder: (context, state) {
        if (state is InstructorLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InstructorsLoaded) {
          return buildInstructorSelect(context, state.instructors);
        } else if (state is InstructorError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No instructors available'));
        }
      },
    );
  }

  Container buildInstructorSelect(BuildContext context, List<UserInfo> instructors) {
    return Container(
      margin: EdgeInsets.only(top: 15, right: MediaQuery.of(context).size.width * 0.4),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: BlocBuilder<CreateReservationBloc, CreateReservationState>(
        builder: (context, state) {
          return DropdownButton<int>(
            value: state.instructorSelected,
            items: instructors.map((instructor) {
              return DropdownMenuItem<int>(
                value: instructor.id,
                child: Text(instructor.name),
              );
            }).toList(),
            onChanged: (value) {
              debugPrint("Instructor seleccionado: $value");
              if (value != null) {
                context.read<CreateReservationBloc>().add(CreateReservationSetInstructorEvent(instructorId: value));
              }
            },
            hint: const Text("Agregar instructor"),
          );
        },
      ),
    );
  }
}
