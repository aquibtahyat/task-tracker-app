import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/domain/entities/add_comment_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';
import 'package:task_tracker_app/src/domain/entities/create_task_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';

abstract interface class TaskRepository {
  Future<Result<List<TaskEntity>>> getTasks();
  Future<Result<TaskEntity>> createTask(CreateTaskRequestEntity request);
  Future<Result<TaskEntity>> updateTask(TaskEntity task);
  Future<Result<List<CommentEntity>>> getComments(String taskId);
  Future<Result<CommentEntity>> addComment(AddCommentRequestEntity request);
}
