import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskminder/bloc/bloc_exports.dart';
import 'package:taskminder/bloc/onboarding_bloc.dart';
import 'package:taskminder/models/onboarding.dart';
import 'package:taskminder/screens/home_screen.dart';
import 'package:taskminder/screens/main_screen.dart';
import 'package:taskminder/styles/colors.dart';
import 'package:taskminder/widgets/onboarding_item_widget.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController onboardingController = PageController();

  final List<OnboardingModel> onboardings = [
    OnboardingModel(
      title: 'Welcome to TaskMinder',
      body: 'Stay organized and on top of your tasks with our powerful task management app',
      image: 'onboarding_one.png',
    ),
    OnboardingModel(
      title: 'Add, Edit, and Delete Tasks',
      body:
          'Easily create new tasks, edit existing ones, and delete tasks when they\'re no longer needed, Keep your to-do list up to date and organized',
      image: 'onboarding_two.png',
    ),
    OnboardingModel(
      title: 'Stay Organized',
      body: 'Keep your tasks organized with our intuitive task categories. Effortlessly manage pending, favorite, completed, and overdue tasks',
      image: 'onboarding_three.png',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              context.read<OnboardingBloc>().add(SkipEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
            child: const Text(
              'SKIP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return OnboardingItem(onboardingItem: onboardings[index]);
                },
                itemCount: onboardings.length,
                physics: const BouncingScrollPhysics(),
                controller: onboardingController,
                onPageChanged: (int index) {
                  if (index == onboardings.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onboardingController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Color(0xFFCCCCCC),
                    activeDotColor: primaryColor,
                    dotHeight: 4.0,
                    expansionFactor: 4.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                  count: onboardings.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      context.read<OnboardingBloc>().add(SkipEvent());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    } else {
                      onboardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: isLast ? const Icon(Icons.check) : const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
