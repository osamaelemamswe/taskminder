import 'package:flutter/material.dart';
import 'package:taskminder/bloc/bloc_exports.dart';
import 'package:taskminder/models/task.dart';

class TaskTileWidget extends StatelessWidget {
  const TaskTileWidget({
    Key? key,
    required this.task,
    required this.isOverdue,
  }) : super(key: key);

  final Task task;
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isOverdue)
                  Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    side: const BorderSide(width: 1.0),
                    value: task.isCompleted,
                    onChanged: (value) {
                      context.read<TasksBloc>().add(CompleteTaskEvent(task: task));
                    },
                  ),
                if (isOverdue) const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              decoration: task.isCompleted! ? TextDecoration.lineThrough : null,
                            ),
                      ),
                      if (task.deadLine != null && task.deadLine!.isNotEmpty) const SizedBox(height: 10.0),
                      if (task.deadLine != null && task.deadLine!.isNotEmpty)
                        Row(
                          children: [
                            if (!isOverdue)
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 14.0,
                              ),
                            if (isOverdue)
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.red,
                                size: 14.0,
                              ),
                            const SizedBox(width: 5.0),
                            if (!isOverdue) Text(task.deadLine!),
                            if (isOverdue)
                              Text(
                                task.deadLine!,
                                style: const TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!task.isCompleted! && !isOverdue)
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<TasksBloc>().add(FavoriteTaskEvent(task: task));
                  },
                  icon: task.isFavorite! ? const Icon(Icons.star, color: Colors.yellow) : const Icon(Icons.star_outline),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
