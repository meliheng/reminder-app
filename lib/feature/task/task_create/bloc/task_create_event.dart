part of 'task_create_bloc.dart';

sealed class TaskCreateEvent extends Equatable {
  const TaskCreateEvent();

  @override
  List<Object> get props => [];
}

final class TaskCreateTitleChangedEvent extends TaskCreateEvent {
  final String? title;

  const TaskCreateTitleChangedEvent({this.title});
}

final class TaskCreateDateChangedEvent extends TaskCreateEvent {
  final DateTime? date;

  const TaskCreateDateChangedEvent({this.date});
}

final class TaskCreateTimeChangedEvent extends TaskCreateEvent {
  final TimeOfDay? time;

  const TaskCreateTimeChangedEvent({this.time});
}

final class TaskCreateSaveEvent extends TaskCreateEvent {
  final BuildContext context;

  const TaskCreateSaveEvent({required this.context});
}

final class TaskCreateClearEvent extends TaskCreateEvent {
  const TaskCreateClearEvent();
}
