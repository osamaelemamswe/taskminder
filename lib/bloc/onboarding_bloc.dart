import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends HydratedBloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitialState(isFirstTime: true)) {
    on<SkipEvent>((event, emit) {
      emit(const OnboardingState(isFirstTime: false));
    });
  }

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) {
    return OnboardingState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    return state.toMap();
  }
}