import 'package:flutter/material.dart';
import 'package:taskminder/bloc/bloc_exports.dart';
import 'package:taskminder/screens/completed_screen.dart';
import 'package:taskminder/screens/favorites_screen.dart';
import 'package:taskminder/screens/overdue_screen.dart';
import 'package:taskminder/screens/pending_screen.dart';
import 'package:taskminder/styles/colors.dart';
import 'package:taskminder/widgets/add_task_form_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool switchValue = false;

  final List<Map<String, dynamic>> _pages = [
    {
      'screen': const PendingScreen(),
      'title': 'Pending Screen',
    },
    {
      'screen': const FavoritesScreen(),
      'title': 'Favorites Screen',
    },
    {
      'screen': const CompletedScreen(),
      'title': 'Completed Screen',
    },
    {
      'screen': const OverdueScreen(),
      'title': 'Overdue Screen',
    },
  ];

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return Switch(
                value: state.switchValue,
                onChanged: (newValue) {
                  newValue ? context.read<SwitchBloc>().add(SwitchOnEvent()) : context.read<SwitchBloc>().add(SwitchOffEvent());
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(child: _pages[_selectedPageIndex]['screen']),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                context.read<TasksBloc>().add(UpdateOverdueTasksEvent());
                setState(() {
                  _selectedPageIndex = 0;
                });
              },
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Icon(
                          Icons.pending_actions_outlined,
                          color: _selectedPageIndex == 0
                              ? primaryColor
                              : state.switchValue
                                  ? Colors.white
                                  : Colors.black,
                        );
                      },
                    ),
                    const SizedBox(height: 5.0),
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Text(
                          'Pending',
                          style: TextStyle(
                            color: _selectedPageIndex == 0
                                ? primaryColor
                                : state.switchValue
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 12.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Icon(
                          Icons.star_border_outlined,
                          color: _selectedPageIndex == 1
                              ? primaryColor
                              : state.switchValue
                                  ? Colors.white
                                  : Colors.black,
                        );
                      },
                    ),
                    const SizedBox(height: 5.0),
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Text(
                          'Favorites',
                          style: TextStyle(
                            color: _selectedPageIndex == 1
                                ? primaryColor
                                : state.switchValue
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 12.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPageIndex = 2;
                });
              },
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Icon(
                          Icons.task_outlined,
                          color: _selectedPageIndex == 2
                              ? primaryColor
                              : state.switchValue
                                  ? Colors.white
                                  : Colors.black,
                        );
                      },
                    ),
                    const SizedBox(height: 5.0),
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Text(
                          'Completed',
                          style: TextStyle(
                            color: _selectedPageIndex == 2
                                ? primaryColor
                                : state.switchValue
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 12.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPageIndex = 3;
                });
              },
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Icon(
                          Icons.sms_failed_outlined,
                          color: _selectedPageIndex == 3
                              ? primaryColor
                              : state.switchValue
                                  ? Colors.white
                                  : Colors.black,
                        );
                      },
                    ),
                    const SizedBox(height: 5.0),
                    BlocBuilder<SwitchBloc, SwitchState>(
                      builder: (context, state) {
                        return Text(
                          'Overdue',
                          style: TextStyle(
                            color: _selectedPageIndex == 3
                                ? primaryColor
                                : state.switchValue
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 12.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: state.switchValue ? const Color(0xFF0F141A) : Colors.white,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return AddTaskFormWidget();
                },
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
