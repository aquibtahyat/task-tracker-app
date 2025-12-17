enum TaskType {
  todo('todo', 'To Do'),
  inProgress('in_progress', 'In Progress'),
  done('done', 'Done');

  final String type;
  final String displayName;
  const TaskType(this.type, this.displayName);
}
