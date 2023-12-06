part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({required this.isFirstTime});

  final bool isFirstTime;

  @override
  List<Object> get props => [isFirstTime];

  Map<String, dynamic> toMap() {
    return {
      'isFirstTime': isFirstTime,
    };
  }

  factory OnboardingState.fromMap(Map<String, dynamic> map) {
    return OnboardingState(isFirstTime: map['isFirstTime'] ?? false);
  }
}

class OnboardingInitialState extends OnboardingState {
  const OnboardingInitialState({required bool isFirstTime}) : super(isFirstTime: isFirstTime);
}