import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/core/base/use_case.dart';
import 'package:task_tracker_app/src/domain/use_cases/get_tasks.dart';

@injectable
class GetTasksCubit extends Cubit<BaseState> {
  GetTasksCubit(this._getTasksUseCase) : super(InitialState());

  final GetTasksUseCase _getTasksUseCase;

  Future<void> getTasks() async {
    emit(const LoadingState());

    final result = await _getTasksUseCase.call(NoParams());

    if (result.isSuccess) {
      final tasks = result.data ?? [];
      emit(SuccessState(tasks));
    } else {
      emit(FailureState(result.message ?? 'Something went wrong'));
    }
  }
}
