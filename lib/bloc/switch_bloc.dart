import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchInitialState(switchValue: false)) {
    on<SwitchOnEvent>((event, emit) {
      emit(SwitchState(switchValue: true));
    });

    on<SwitchOffEvent>((event, emit) {
      emit(SwitchState(switchValue: false));
    });
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}