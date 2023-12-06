import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskminder/bloc/bloc_exports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: state.switchValue ? const Color(0xFF121920) : Colors.white,
            child: state.switchValue ? Image.asset('assets/images/taskminder_logo_dark.png') : Image.asset('assets/images/taskminder_logo.png'),
          );
        },
      ),
    );
  }
}
