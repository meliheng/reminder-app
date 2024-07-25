import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/feature/task/task_create/view/task_dialog.dart';
import 'package:taskapp/feature/task/task_list/bloc/task_bloc.dart';
import 'package:taskapp/feature/task/task_list/view/task_card.dart';

class TaskView extends StatefulWidget {
  final VoidCallback changeTheme;
  const TaskView({super.key, required this.changeTheme});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  // late bool isDarkMode;
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     isDarkMode = Theme.of(context).brightness == Brightness.dark;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remind Me'),
        actions: const [
          // IconButton(
          //   onPressed: widget.changeTheme,
          //   icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        onPressed: () {
          const TaskDialog().showTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        bloc: context.read<TaskBloc>()..add(TaskLoadEvent()),
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskLoadedState) {
            return ListView.builder(
              itemCount: state.tasks?.length,
              itemBuilder: (context, index) {
                return TaskCard(
                    task: state.tasks![index],
                    onDeletePressed: () {
                      context
                          .read<TaskBloc>()
                          .add(TaskDeleteEvent(task: state.tasks![index]));
                    });
              },
            );
          } else if (state is TaskErrorState) {
            return Center(
              child: Text(state.message ?? ""),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
