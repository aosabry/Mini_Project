import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';
import '../widgets/stats_section.dart';
import '../widgets/filter_section.dart';
import '../widgets/task_item_card.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xFF536DFE),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Text(
              'Tasks Overview',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          final tasks = state.tasks;
          final selectedFilter = state.selectedFilter;

          List<Map<String, dynamic>> filteredTasks = tasks.where((task) {
            if (selectedFilter == 'Completed') return task['completed'];
            if (selectedFilter == 'Pending') return !task['completed'];
            return true;
          }).toList();

          int totalTasks = tasks.length;
          int completedTasks = tasks.where((t) => t['completed']).length;
          int pendingTasks = totalTasks - completedTasks;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatsSection(
                  totalTasks: totalTasks,
                  completedTasks: completedTasks,
                  pendingTasks: pendingTasks,
                ),
                SizedBox(height: 24),
                FilterSection(selectedFilter: selectedFilter),
                SizedBox(height: 24),
                Text(
                  'Tasks (${filteredTasks.length})',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    final originalIndex = tasks.indexOf(task);

                    return TaskItemCard(
                      task: task,
                      originalIndex: originalIndex,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
