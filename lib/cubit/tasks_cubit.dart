import 'package:flutter_bloc/flutter_bloc.dart';

import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitState());

  void changeFilter(String filter) {
    final currentTasks = List<Map<String, dynamic>>.from(
      state.tasks.map((task) => Map<String, dynamic>.from(task)),
    );
    emit(TasksUpdateState(currentTasks, filter));
  }

  void toggleTaskCompletion(int originalIndex, bool? value) {
    final updatedTasks = List<Map<String, dynamic>>.from(
      state.tasks.map((task) => Map<String, dynamic>.from(task)),
    );
    updatedTasks[originalIndex]['completed'] = value ?? false;

    emit(TasksUpdateState(updatedTasks, state.selectedFilter));
  }

  void deleteTask(int originalIndex) {
    final updatedTasks = List<Map<String, dynamic>>.from(
      state.tasks.map((task) => Map<String, dynamic>.from(task)),
    );
    updatedTasks.removeAt(originalIndex);

    emit(TasksUpdateState(updatedTasks, state.selectedFilter));
  }
}
