part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TasksEvent {
  const AddTaskEvent({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class CompleteTaskEvent extends TasksEvent {
  const CompleteTaskEvent({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class FavoriteTaskEvent extends TasksEvent {
  const FavoriteTaskEvent({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class EditTaskEvent extends TasksEvent {
  const EditTaskEvent({
    required this.oldTask,
    required this.newTask,
  });

  final Task oldTask;
  final Task newTask;

  @override
  List<Object> get props => [oldTask, newTask];
}

class DeleteTaskEvent extends TasksEvent {
  const DeleteTaskEvent({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class UpdateOverdueTasksEvent extends TasksEvent {
  @override
  List<Object> get props => [];
}
