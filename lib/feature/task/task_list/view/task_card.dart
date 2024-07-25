import 'package:flutter/material.dart';
import 'package:taskapp/feature/task/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onDeletePressed;
  const TaskCard({
    super.key,
    required this.task,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(task.title ?? ""),
        subtitle: Text("${task.date ?? ""} ${task.time ?? ""}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDeletePressed,
        ),
      ),
    );
  }
}
