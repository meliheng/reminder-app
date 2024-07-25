import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/feature/task/model/task.dart';
import 'package:taskapp/product/util/hive/hive_manager.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskLoadingState()) {
    on<TaskLoadEvent>(_loadEvent);
    on<TaskAddEvent>(_addEvent);
    on<TaskUpdateEvent>(_updateEvent);
    on<TaskDeleteEvent>(_deleteEvent);
  }

  FutureOr<void> _loadEvent(TaskLoadEvent event, emit) async {
    if (event.task != null) {
      emit(TaskLoadedState(tasks: [event.task!]));
      return;
    }
    await HiveManager.getData<List>(key: "task", boxName: "task").then((value) {
      if (value != null) {
        return emit(TaskLoadedState(
            tasks: value.data?.map((e) => Task.fromJson(e)).toList()));
      }
      return emit(const TaskErrorState(message: "No data found"));
    });
  }

  FutureOr<void> _addEvent(event, emit) async {
    List<Task> value = [];
    if (state is TaskLoadedState) {
      value = (state as TaskLoadedState).tasks ?? [];
      value.add(event.task);
    } else {
      value.add(event.task);
    }
    await HiveManager.saveData<List<Map<String, dynamic>>>(
        key: "task",
        boxName: "task",
        data: value.map((e) => e.toJson()).toList());
    return emit(TaskLoadedState(tasks: value));
  }

  FutureOr<void> _updateEvent(TaskUpdateEvent event, Emitter<TaskState> emit) {
    if (state is TaskLoadedState) {
      emit(TaskLoadedState(tasks: (state as TaskLoadedState).tasks));
    }
  }

  FutureOr<void> _deleteEvent(TaskDeleteEvent event, Emitter<TaskState> emit) {
    if (state is TaskLoadedState) {
      List<Task> value = (state as TaskLoadedState).tasks ?? [];
      value.remove(event.task);
      emit(TaskLoadedState(tasks: value));
      HiveManager.saveData<List<Map<String, dynamic>>>(
          key: "task",
          boxName: "task",
          data: value.map((e) => e.toJson()).toList());
    }
  }
}
