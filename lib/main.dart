import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskminder/bloc/bloc_exports.dart';
import 'package:taskminder/bloc/onboarding_bloc.dart';
import 'package:taskminder/screens/main_screen.dart';
import 'package:taskminder/screens/onboarding_screen.dart';
import 'package:taskminder/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
        BlocProvider(create: (context) => OnboardingBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaskMinder',
            theme: state.switchValue ? darkTheme : lightTheme,
            home: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                return state.isFirstTime ? OnboardingScreen() : const MainScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
