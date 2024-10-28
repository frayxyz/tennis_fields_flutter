import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/interfaces/rain_probability_service.dart';

class RainProbabilityEvent {}

class FetchRainProbability extends RainProbabilityEvent {
  final String date;
  final String time;

  FetchRainProbability(this.date, this.time);
}

class RainProbabilityState {}
class RainProbabilityInitial extends RainProbabilityState {}

class RainProbabilityLoading extends RainProbabilityState {}

class RainProbabilityLoaded extends RainProbabilityState {
  final int probability;

  RainProbabilityLoaded(this.probability);
}

class RainProbabilityError extends RainProbabilityState {
  final String message;

  RainProbabilityError(this.message);
}

class RainProbabilityBloc extends Bloc<RainProbabilityEvent, RainProbabilityState> {
  final RainProbabilityServiceI rainProbabilityService;

  RainProbabilityBloc(this.rainProbabilityService) : super(RainProbabilityInitial()) {
    on<RainProbabilityEvent>((event, emit) async {
      if (event is FetchRainProbability) {
        emit(RainProbabilityLoading());
        try {
          debugPrint("consultando api lluvia ${event.date}");
          final probability = await rainProbabilityService.getRainProbability(event.date, event.time);
          if (probability != null) {
            emit(RainProbabilityLoaded(probability));
          } else {
            emit(RainProbabilityError("No data available"));
          }
        } catch (e) {
          emit(RainProbabilityError("Error: ${e.toString()}"));
        }
      }
    });
  }
}
