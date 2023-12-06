import 'package:flutter/material.dart';
import 'package:taskminder/models/onboarding.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    Key? key,
    required this.onboardingItem,
  }) : super(key: key);

  final OnboardingModel onboardingItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          onboardingItem.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.0),
        Text(
          onboardingItem.body,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 30.0),
        Image.asset(
          'assets/images/${onboardingItem.image}',
        ),
      ],
    );
  }
}
