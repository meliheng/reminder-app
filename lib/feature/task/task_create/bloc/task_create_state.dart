part of 'task_create_bloc.dart';

sealed class TaskCreateState extends Equatable {
  const TaskCreateState();

  @override
  List<Object?> get props => [];
}

final class TaskCreateInitial extends TaskCreateState {
  final String? title;
  final DateTime? date;
  final TimeOfDay? time;
  final String? error;

  const TaskCreateInitial({this.title, this.date, this.time, this.error});

  TaskCreateInitial copyWith({
    String? title,
    DateTime? date,
    TimeOfDay? time,
    String? error,
  }) {
    return TaskCreateInitial(
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [title, date, time, error];
}

final class TaskCreateLoading extends TaskCreateState {}
