import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/enums/task_type.dart';
import 'package:task_tracker_app/src/domain/use_cases/update_task.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/task_manager/task_manager_state.dart';

@injectable
class TaskManagerCubit extends Cubit<TaskManagerState> {
  TaskManagerCubit(this._updateTaskUseCase) : super(TaskManagerState());

  final UpdateTaskUseCase _updateTaskUseCase;

  void populateTasks(List<TaskEntity> tasks) {
    try {
      _groupAndEmitTasks(tasks);
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          message: 'Couldn\'t load tasks, ${e.toString()}',
        ),
      );
    }
  }

  void _groupAndEmitTasks(List<TaskEntity> allTasks) {
    final todo = allTasks
        .where((task) => task.getCurrentLabel() == TaskType.todo)
        .toList();
    final inProgress = allTasks
        .where((task) => task.getCurrentLabel() == TaskType.inProgress)
        .toList();
    final done = allTasks
        .where((task) => task.getCurrentLabel() == TaskType.done)
        .toList();

    emit(
      state.copyWith(
        status: TaskStatus.success,
        todoTasks: todo,
        inProgressTasks: inProgress,
        doneTasks: done,
        message: null,
        loadingTaskIds: {},
      ),
    );
  }

  void _updateLocalTasks(List<TaskEntity> updatedTasks) {
    if (updatedTasks.isEmpty) return;

    List<TaskEntity> allTasks = [
      ...state.todoTasks,
      ...state.inProgressTasks,
      ...state.doneTasks,
    ];

    for (final updatedTask in updatedTasks) {
      final index = allTasks.indexWhere((t) => t.id == updatedTask.id);
      if (index != -1) {
        allTasks[index] = updatedTask;
      } else {
        allTasks.add(updatedTask);
      }
    }
    _groupAndEmitTasks(allTasks);
  }

  Future<void> moveTask(TaskEntity taskToMove, TaskType newLabel) async {
    final taskId = taskToMove.id;
    if (taskId == null) return;

    Set<String> loadingIds = {taskId};

    if (newLabel == TaskType.inProgress && state.inProgressTasks.isNotEmpty) {
      final existingWipTaskId = state.inProgressTasks.first.id;
      if (existingWipTaskId != null) {
        loadingIds.add(existingWipTaskId);
      }
    }

    emit(
      state.copyWith(
        status: TaskStatus.loading,
        message: null,
        loadingTaskIds: loadingIds,
      ),
    );

    if (newLabel == TaskType.inProgress && state.inProgressTasks.isNotEmpty) {
      await _handleWipLimitMove(taskToMove, newLabel);
    } else {
      await _handleSimpleMove(taskToMove, newLabel);
    }
  }

  Future<void> _handleSimpleMove(
    TaskEntity taskToMove,
    TaskType newLabel,
  ) async {
    final payload = taskToMove.copyWith(labels: [newLabel.type]);

    final result = await _updateTaskUseCase.call(payload);

    if (result.isSuccess) {
      if (result.data != null) {
        _updateLocalTasks([result.data!]);
      }
    } else {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          message: result.message ?? 'Failed to move task',
          loadingTaskIds: {},
        ),
      );
    }
  }

  Future<void> _handleWipLimitMove(
    TaskEntity incomingTask,
    TaskType newLabel,
  ) async {
    final TaskEntity existingWipTask = state.inProgressTasks.first;

    final TaskEntity wipToTodoPayload = existingWipTask.copyWith(
      labels: [TaskType.todo.type],
      completedAt: null,
    );

    try {
      final wipResult = await _updateTaskUseCase.call(wipToTodoPayload);

      if (!wipResult.isSuccess) {
        emit(
          state.copyWith(
            status: TaskStatus.failure,
            message: wipResult.message,
            loadingTaskIds: {},
          ),
        );
        return;
      }
      final TaskEntity incomingToWipPayload = incomingTask.copyWith(
        labels: [newLabel.type],
        completedAt: null,
      );

      final incomingResult = await _updateTaskUseCase.call(
        incomingToWipPayload,
      );

      if (incomingResult.isSuccess) {
        if (wipResult.data != null && incomingResult.data != null) {
          _updateLocalTasks([wipResult.data!, incomingResult.data!]);
        } else {
          emit(
            state.copyWith(
              status: TaskStatus.failure,
              message: 'Failed to update tasks: missing data',
              loadingTaskIds: {},
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: TaskStatus.failure,
            message: incomingResult.message ?? 'Failed to move task',
            loadingTaskIds: {},
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          message: 'Something went wrong, ${e.toString()}',
          loadingTaskIds: {},
        ),
      );
    }
  }
}
