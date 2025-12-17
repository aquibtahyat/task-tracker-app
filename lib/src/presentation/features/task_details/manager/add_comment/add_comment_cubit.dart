import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/domain/entities/add_comment_request_entity.dart';
import 'package:task_tracker_app/src/domain/use_cases/add_comment.dart';

@injectable
class AddCommentCubit extends Cubit<BaseState> {
  final AddCommentUseCase _addCommentUseCase;

  AddCommentCubit(this._addCommentUseCase) : super(InitialState());

  Future<void> addComment(AddCommentRequestEntity request) async {
    emit(LoadingState());
    final result = await _addCommentUseCase(request);
    if (result.isSuccess) {
      emit(SuccessState(result.data));
    } else {
      emit(FailureState(result.message ?? 'Something went wrong'));
    }
  }
}
