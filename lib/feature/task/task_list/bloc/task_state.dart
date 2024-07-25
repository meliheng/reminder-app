part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskLoadedState extends TaskState {
  final List<Task>? tasks;

  const TaskLoadedState({this.tasks});

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class TaskLoadingState extends TaskState {}

final class TaskErrorState extends TaskState {
  final String? message;

  const TaskErrorState({this.message});

  @override
  List<Object> get props => [message ?? ''];
}
