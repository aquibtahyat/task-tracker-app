import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';

enum TaskStatus { initial, loading, success, failure }

class TaskManagerState extends Equatable {
  final TaskStatus status;
  final List<TaskEntity> todoTasks;
  final List<TaskEntity> inProgressTasks;
  final List<TaskEntity> doneTasks;
  final String message;
  final Set<String> loadingTaskIds;

  const TaskManagerState({
    this.status = TaskStatus.initial,
    this.todoTasks = const [],
    this.inProgressTasks = const [],
    this.doneTasks = const [],
    this.message = '',
    this.loadingTaskIds = const {},
  });

  @override
  List<Object?> get props => [
    status,
    todoTasks,
    inProgressTasks,
    doneTasks,
    message,
    loadingTaskIds,
  ];

  TaskManagerState copyWith({
    TaskStatus? status,
    List<TaskEntity>? todoTasks,
    List<TaskEntity>? inProgressTasks,
    List<TaskEntity>? doneTasks,
    String? message,
    Set<String>? loadingTaskIds,
  }) {
    return TaskManagerState(
      status: status ?? this.status,
      todoTasks: todoTasks ?? this.todoTasks,
      inProgressTasks: inProgressTasks ?? this.inProgressTasks,
      doneTasks: doneTasks ?? this.doneTasks,
      message: message ?? this.message,
      loadingTaskIds: loadingTaskIds ?? this.loadingTaskIds,
    );
  }
}
