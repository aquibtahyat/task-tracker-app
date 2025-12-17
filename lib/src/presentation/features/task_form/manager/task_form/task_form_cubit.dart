import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/domain/entities/create_task_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/use_cases/create_task.dart';
import 'package:task_tracker_app/src/domain/use_cases/update_task.dart';

@injectable
class TaskFormCubit extends Cubit<BaseState> {
  TaskFormCubit(this._createTaskUseCase, this._updateTaskUseCase)
    : super(InitialState());

  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  Future<void> createTask({String? content, String? description}) async {
    emit(LoadingState());

    final CreateTaskRequestEntity task = CreateTaskRequestEntity(
      content: content,
      description: description,
    );
    final result = await _createTaskUseCase(task);

    if (result.isSuccess) {
      emit(SuccessState(result.data));
    } else {
      emit(FailureState(result.message ?? 'Something went wrong'));
    }
  }

  Future<void> editTask(TaskEntity task) async {
    emit(LoadingState());
    final result = await _updateTaskUseCase(task);

    if (result.isSuccess) {
      emit(SuccessState(result.data));
    } else {
      emit(FailureState(result.message ?? 'Something went wrong'));
    }
  }
}
