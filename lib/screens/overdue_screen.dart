import 'package:flutter/material.dart';
import 'package:taskminder/bloc/bloc_exports.dart';
import 'package:taskminder/models/task.dart';
import 'package:taskminder/widgets/tasks_list_widget.dart';

class OverdueScreen extends StatelessWidget {
  const OverdueScreen({Key? key}) : super(key: key);

  static const id = 'overdue_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.overdueTasks;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (tasksList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TasksListWidget(
                    tasksList: tasksList,
                    isPendingTasks: false,
                    isCompletedTasks: false,
                    isOverdueTasks: true,
                  ),
                ),
              if (tasksList.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'No overdue tasks yet',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
