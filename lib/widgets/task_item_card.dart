import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tasks_cubit.dart';

class TaskItemCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final int originalIndex;

  const TaskItemCard({
    super.key,
    required this.task,
    required this.originalIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(35),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Color(0xFF536DFE),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        value: task['completed'],
        onChanged: (bool? value) {
          context.read<TasksCubit>().toggleTaskCompletion(originalIndex, value);
        },
        title: Text(
          task['title'],
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: task['completed'] ? Colors.grey : Colors.black,
            decoration: task['completed']
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        secondary: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            context.read<TasksCubit>().deleteTask(originalIndex);
          },
        ),
      ),
    );
  }
}
