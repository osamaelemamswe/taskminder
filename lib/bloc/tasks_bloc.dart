import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskminder/models/task.dart';

import 'package:equatable/equatable.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_onAddTask);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<FavoriteTaskEvent>(_onFavoriteTask);
    on<EditTaskEvent>(_onEditTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<UpdateOverdueTasksEvent>(_onUpdateOverdueTasks);
  }

  void _onUpdateOverdueTasks(UpdateOverdueTasksEvent event, Emitter<TasksState> emit) {
    final DateTime currentDateTime = DateTime.now();

    final List<Task> overdue = [];
    final List<Task> pending = [];
    final List<Task> completed = [];

    for (final Task task in state.pendingTasks) {
      if (task.deadLine!.isNotEmpty) {
        final DateTime deadline = DateFormat('dd-MM-yyyy HH:mm').parse(task.deadLine!);

        if (!task.isCompleted! && deadline.isBefore(currentDateTime)) {
          overdue.add(task);
        } else {
          pending.add(task);
        }
      } else {
        pending.add(task);
      }
    }

    for (final Task task in state.completedTasks) {
      completed.add(task);
    }

    for (final Task task in state.overdueTasks) {
      overdue.add(task);
    }

    emit(TasksState(
      pendingTasks: pending,
      completedTasks: completed,
      overdueTasks: overdue,
    ));
  }

  void _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;

    add(UpdateOverdueTasksEvent());

    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: List.from(state.completedTasks),
      overdueTasks: List.from(state.overdueTasks),
    ));
  }

  void _onCompleteTask(CompleteTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    if (task.isCompleted!) {
      completedTasks = List.from(completedTasks)..remove(task);
      pendingTasks = List.from(pendingTasks)..add(task.copyWith(isCompleted: false));
    } else {
      completedTasks = List.from(completedTasks)..add(task.copyWith(isCompleted: true));
      pendingTasks = List.from(pendingTasks)..remove(task);
    }

    add(UpdateOverdueTasksEvent());

    emit(TasksState(
      pendingTasks: List.from(pendingTasks),
      completedTasks: List.from(completedTasks),
      overdueTasks: List.from(state.overdueTasks),
    ));
  }

  void _onFavoriteTask(FavoriteTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;

    if (task.isFavorite!) {
      pendingTasks = List.from(pendingTasks)..remove(task);
      pendingTasks.insert(0, task.copyWith(isFavorite: false));
    } else {
      pendingTasks = List.from(pendingTasks)..remove(task);
      pendingTasks.insert(0, task.copyWith(isFavorite: true));
    }

    add(UpdateOverdueTasksEvent());

    emit(TasksState(
      pendingTasks: List.from(pendingTasks),
      completedTasks: List.from(state.completedTasks),
      overdueTasks: List.from(state.overdueTasks),
    ));
  }

  void _onEditTask(EditTaskEvent event, Emitter<TasksState> emit) {
    add(UpdateOverdueTasksEvent());

    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: List.from(state.completedTasks)..remove(event.oldTask),
        overdueTasks: List.from(state.overdueTasks),
      ),
    );
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;

    add(UpdateOverdueTasksEvent());

    if (task.isCompleted!) {
      emit(TasksState(
        pendingTasks: List.from(state.pendingTasks),
        completedTasks: List.from(state.completedTasks)..remove(task),
        overdueTasks: List.from(state.overdueTasks),
      ));
    } else {
      emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(task),
        completedTasks: List.from(state.completedTasks),
        overdueTasks: List.from(state.overdueTasks)..remove(task),
      ));
    }
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
