import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/feature/task/task_create/bloc/task_create_bloc.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key});

  Future<void> showTaskDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<TaskCreateBloc>(context),
          child: const TaskDialog(),
        );
      },
    );
  }

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final TextEditingController _taskController = TextEditingController();
  late TaskCreateBloc taskCreateBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    taskCreateBloc = BlocProvider.of<TaskCreateBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    taskCreateBloc.add(const TaskCreateClearEvent());
    _taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Task'),
      content: SingleChildScrollView(
        child: BlocConsumer<TaskCreateBloc, TaskCreateState>(
          bloc: taskCreateBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TaskCreateInitial) {
              return _mainBuilder(context, state);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            taskCreateBloc.add(TaskCreateSaveEvent(context: context));
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Column _mainBuilder(BuildContext context, TaskCreateInitial state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _taskController,
          onChanged: (value) {
            taskCreateBloc.add(
              TaskCreateTitleChangedEvent(title: value),
            );
          },
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () async {
                var selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (context.mounted) {
                  context
                      .read<TaskCreateBloc>()
                      .add(TaskCreateDateChangedEvent(date: selectedDate));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey[200],
                child: Text(
                  state.date != null
                      ? DateFormat('dd/MM/yyyy').format(state.date!)
                      : 'Select Date',
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (context.mounted) {
                  context
                      .read<TaskCreateBloc>()
                      .add(TaskCreateTimeChangedEvent(time: selectedTime));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey[200],
                child: Text(
                  state.time != null
                      ? state.time!.format(context)
                      : 'Select Time',
                ),
              ),
            ),
          ],
        ),
        if (state.error != null) ...[
          const SizedBox(height: 10),
          Text(
            state.error!,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ],
    );
  }
}
