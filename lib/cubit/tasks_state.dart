abstract class TasksState {
  final List<Map<String, dynamic>> tasks;
  final String selectedFilter;

  TasksState(this.tasks, this.selectedFilter);
}

class TasksInitState extends TasksState {
  TasksInitState()
    : super([
        {'title': 'Buy groceries', 'completed': false},
        {'title': 'Go to the gym', 'completed': false},
        {'title': 'Read a book', 'completed': false},
        {'title': 'Plan tomorrow', 'completed': false},
      ], 'All');
}

class TasksUpdateState extends TasksState {
  TasksUpdateState(super.tasks, super.selectedFilter);
}
