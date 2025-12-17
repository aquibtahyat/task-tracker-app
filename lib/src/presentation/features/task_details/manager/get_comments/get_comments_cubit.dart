import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/domain/use_cases/get_comments.dart';

@injectable
class GetCommentsCubit extends Cubit<BaseState> {
  final GetCommentsUseCase _getCommentsUseCase;

  GetCommentsCubit(this._getCommentsUseCase) : super(InitialState());

  Future<void> getComments(String taskId) async {
    emit(LoadingState());
    final result = await _getCommentsUseCase.call(taskId);

    if (result.isSuccess) {
      emit(SuccessState(result.data ?? []));
    } else {
      emit(FailureState(result.message ?? 'Something went wrong'));
    }
  }
}
