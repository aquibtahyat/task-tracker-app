import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/core/base/use_case.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';
import 'package:task_tracker_app/src/domain/repositories/task_repository.dart';

@injectable
class GetCommentsUseCase
    implements UseCase<Result<List<CommentEntity>>, String> {
  final TaskRepository _taskRepository;

  GetCommentsUseCase(this._taskRepository);

  @override
  Future<Result<List<CommentEntity>>> call(String taskId) {
    return _taskRepository.getComments(taskId);
  }
}
