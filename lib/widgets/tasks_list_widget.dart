import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskminder/models/task.dart';
import 'package:taskminder/widgets/tasks_expansion_list_widget.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({
    Key? key,
    required this.tasksList,
    required this.isPendingTasks,
    required this.isCompletedTasks,
    required this.isOverdueTasks,
  }) : super(key: key);

  final List<Task> tasksList;
  final bool isPendingTasks;
  final bool isCompletedTasks;
  final bool isOverdueTasks;

  @override
  Widget build(BuildContext context) {
    List<Task> deadlineTasks = [];
    List<Task> todayTasks = [];
    List<Task> tomorrowTasks = [];
    List<Task> upcomingTasks = [];
    List<Task> noDeadlineTasks = [];

    if (isPendingTasks) {
      for (Task task in tasksList) {
        if (task.deadLine!.isNotEmpty) {
          deadlineTasks.add(task);
        } else {
          noDeadlineTasks.add(task);
        }
      }

      DateTime today = DateTime.now();
      DateTime tomorrow = today.add(const Duration(days: 1));

      for (Task task in deadlineTasks) {
        DateTime taskDeadline = DateFormat('dd-MM-yyyy HH:mm').parse(task.deadLine!);

        if (taskDeadline.year == today.year && taskDeadline.month == today.month && taskDeadline.day == today.day) {
          todayTasks.add(task);
        } else if (taskDeadline.year == tomorrow.year && taskDeadline.month == tomorrow.month && taskDeadline.day == tomorrow.day) {
          tomorrowTasks.add(task);
        } else {
          upcomingTasks.add(task);
        }
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todayTasks.isNotEmpty)
              Text(
                'Today',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            if (todayTasks.isNotEmpty) const SizedBox(height: 20.0),
            if (todayTasks.isNotEmpty)
              TasksExpansionListWidget(
                tasksList: todayTasks,
                isPendingTasks: true,
                isCompletedTasks: false,
                isOverdueTasks: false,
              ),
            if (todayTasks.isNotEmpty) const SizedBox(height: 30.0),
            if (tomorrowTasks.isNotEmpty)
              Text(
                'Tomorrow',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            if (tomorrowTasks.isNotEmpty) const SizedBox(height: 20.0),
            if (tomorrowTasks.isNotEmpty)
              TasksExpansionListWidget(
                tasksList: tomorrowTasks,
                isPendingTasks: true,
                isCompletedTasks: false,
                isOverdueTasks: false,
              ),
            if (tomorrowTasks.isNotEmpty) const SizedBox(height: 30.0),
            if (upcomingTasks.isNotEmpty)
              Text(
                'Upcoming',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            if (upcomingTasks.isNotEmpty) const SizedBox(height: 20.0),
            if (upcomingTasks.isNotEmpty)
              TasksExpansionListWidget(
                tasksList: upcomingTasks,
                isPendingTasks: true,
                isCompletedTasks: false,
                isOverdueTasks: false,
              ),
            if (upcomingTasks.isNotEmpty) const SizedBox(height: 30.0),
            if (noDeadlineTasks.isNotEmpty)
              Text(
                'Unscheduled',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            if (noDeadlineTasks.isNotEmpty) const SizedBox(height: 20.0),
            if (noDeadlineTasks.isNotEmpty)
              TasksExpansionListWidget(
                tasksList: noDeadlineTasks,
                isPendingTasks: true,
                isCompletedTasks: false,
                isOverdueTasks: false,
              ),
            if (noDeadlineTasks.isNotEmpty) const SizedBox(height: 30.0),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tasksList.isNotEmpty) const SizedBox(height: 20.0),
            if (tasksList.isNotEmpty)
              TasksExpansionListWidget(
                tasksList: tasksList,
                isPendingTasks: isPendingTasks,
                isCompletedTasks: isCompletedTasks,
                isOverdueTasks: isOverdueTasks,
              ),
            if (tasksList.isNotEmpty) const SizedBox(height: 30.0),
          ],
        ),
      );
    }
  }
}
