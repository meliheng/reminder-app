part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class TaskLoadEvent extends TaskEvent {
  final Task? task;

  const TaskLoadEvent({this.task});
}

final class TaskAddEvent extends TaskEvent {
  final Task task;

  const TaskAddEvent({required this.task});

  @override
  List<Object> get props => [task];
}

final class TaskUpdateEvent extends TaskEvent {}

final class TaskDeleteEvent extends TaskEvent {
  final Task task;

  const TaskDeleteEvent({required this.task});

  @override
  List<Object> get props => [task];
}
