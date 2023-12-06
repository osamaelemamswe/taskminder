import 'package:flutter/material.dart';
import 'package:taskminder/bloc/bloc_exports.dart';
import 'package:taskminder/models/task.dart';
import 'package:taskminder/widgets/edit_task_form_widget.dart';
import 'package:taskminder/widgets/task_tile_widget.dart';

class TasksExpansionListWidget extends StatelessWidget {
  const TasksExpansionListWidget({
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

  void _deleteTask(BuildContext context, Task task) {
    context.read<TasksBloc>().add(DeleteTaskEvent(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return ExpansionPanelList.radio(
            elevation: 0.0,
            children: tasksList.map((task) {
              return ExpansionPanelRadio(
                backgroundColor: state.switchValue ? const Color(0xFF0F141A) : Colors.white,
                value: task.id,
                headerBuilder: (context, isExpanded) => TaskTileWidget(task: task, isOverdue: isOverdueTasks),
                body: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          task.description!.isNotEmpty ? task.description! : 'No description provided for this task',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isPendingTasks)
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return EditTaskFormWidget(oldTask: task);
                                  },
                                );
                              },
                              child: Text(
                                'Edit',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          TextButton(
                            onPressed: () => _deleteTask(context, task),
                            child: Text(
                              'Delete',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
