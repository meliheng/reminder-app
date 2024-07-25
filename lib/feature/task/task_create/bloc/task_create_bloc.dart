import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/feature/task/model/task.dart';
import 'package:taskapp/feature/task/task_list/bloc/task_bloc.dart';
import 'package:taskapp/product/util/hive/hive_manager.dart';
import 'package:taskapp/product/util/notification/notification_manager.dart';

part 'task_create_event.dart';
part 'task_create_state.dart';

class TaskCreateBloc extends Bloc<TaskCreateEvent, TaskCreateState> {
  final TaskBloc taskBloc;
  TaskCreateBloc({
    required this.taskBloc,
  }) : super(const TaskCreateInitial()) {
    on<TaskCreateSaveEvent>(_onSave);
    on<TaskCreateTitleChangedEvent>(_onTitleChanged);
    on<TaskCreateDateChangedEvent>(_onDateChanged);
    on<TaskCreateTimeChangedEvent>(_onTimeChanged);
    on<TaskCreateClearEvent>(_onClear);
  }
  String? title;
  DateTime? date;
  TimeOfDay? time;

  FutureOr<void> _onSave(
      TaskCreateSaveEvent event, Emitter<TaskCreateState> emit) async {
    List<Map<String, dynamic>> taskList = [];
    if (title == null || title!.isEmpty) {
      emit(TaskCreateInitial(
          date: date, time: time, title: title, error: "Title is required"));
      return;
    }
    if (date == null || time == null) {
      emit(TaskCreateInitial(
          date: date,
          time: time,
          title: title,
          error: "Date and Time is required"));
      return;
    }
    var response =
        await HiveManager.getData<List>(key: "task", boxName: "task");
    var task = Task(
        title: title,
        date: DateFormat('dd/MM/yyyy').format(date!),
        // ignore: use_build_context_synchronously
        time: time!.format(event.context));
    DateTime dateTime =
        DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);
    await NotificationManager.scheduleNotification(
        body: title!, date: dateTime);
    if (response?.data != null) {
      taskList.addAll(response!.data!
          .map((e) => (e as Map<dynamic, dynamic>).cast<String, dynamic>()));
      taskList.add(task.toJson());
    } else {
      taskList.add(task.toJson());
    }
    await HiveManager.saveData<List<Map<String, dynamic>>>(
        key: "task", boxName: "task", data: taskList);
    if (taskBloc.state is! TaskLoadedState) {
      taskBloc.add(TaskLoadEvent(task: task));
      return;
    }
    (taskBloc.state as TaskLoadedState).tasks?.add(task);
    taskBloc.add(TaskUpdateEvent());
  }

  FutureOr<void> _onTitleChanged(
      TaskCreateTitleChangedEvent event, Emitter<TaskCreateState> emit) {
    title = event.title;
    emit(TaskCreateInitial(date: date, time: time, title: title));
  }

  FutureOr<void> _onDateChanged(
      TaskCreateDateChangedEvent event, Emitter<TaskCreateState> emit) {
    date = event.date;
    emit(TaskCreateInitial(date: date, time: time, title: title));
  }

  FutureOr<void> _onTimeChanged(
      TaskCreateTimeChangedEvent event, Emitter<TaskCreateState> emit) {
    time = event.time;
    emit(TaskCreateInitial(date: date, time: time, title: title));
  }

  FutureOr<void> _onClear(
      TaskCreateClearEvent event, Emitter<TaskCreateState> emit) {
    title = null;
    date = null;
    time = null;
    emit(TaskCreateInitial(date: date, time: time, title: title));
  }
}
