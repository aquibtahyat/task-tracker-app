import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/core/base/use_case.dart';
import 'package:task_tracker_app/src/domain/entities/add_comment_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';
import 'package:task_tracker_app/src/domain/repositories/task_repository.dart';

@injectable
class AddCommentUseCase
    implements UseCase<Result<CommentEntity>, AddCommentRequestEntity> {
  final TaskRepository _taskRepository;

  AddCommentUseCase(this._taskRepository);

  @override
  Future<Result<CommentEntity>> call(AddCommentRequestEntity request) {
    return _taskRepository.addComment(request);
  }
}
