part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.overdueTasks = const <Task>[],
  });

  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> overdueTasks;

  @override
  List<Object> get props {
    return [
      pendingTasks,
      completedTasks,
      overdueTasks,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'overdueTasks': overdueTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: List<Task>.from(map['pendingTasks']?.map((x) => Task.fromMap(x))),
      completedTasks: List<Task>.from(map['completedTasks']?.map((x) => Task.fromMap(x))),
      overdueTasks: List<Task>.from(map['overdueTasks']?.map((x) => Task.fromMap(x))),
    );
  }
}
