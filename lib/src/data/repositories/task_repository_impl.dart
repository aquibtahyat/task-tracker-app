import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/repository.dart';
import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/data/data_sources/remote/remote_data_source.dart';
import 'package:task_tracker_app/src/data/mappers/add_comment_request_mapper.dart';
import 'package:task_tracker_app/src/data/mappers/comment_mapper.dart';
import 'package:task_tracker_app/src/data/mappers/create_task_request_mapper.dart';
import 'package:task_tracker_app/src/data/mappers/task_mapper.dart';
import 'package:task_tracker_app/src/data/models/comment_model.dart';
import 'package:task_tracker_app/src/data/models/comment_response_model.dart';
import 'package:task_tracker_app/src/data/models/task_model.dart';
import 'package:task_tracker_app/src/data/models/task_response_model.dart';
import 'package:task_tracker_app/src/domain/entities/add_comment_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';
import 'package:task_tracker_app/src/domain/entities/create_task_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/repositories/task_repository.dart';

@LazySingleton(as: TaskRepository)
final class TaskRepositoryImpl extends Repository implements TaskRepository {
  final RemoteDataSource _dataSource;

  TaskRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<TaskEntity>>> getTasks() {
    return asyncGuard(() async {
      final response = await _dataSource.getTasks();
      final TaskResponseModel data = TaskResponseModel.fromJson(response.data);

      return TaskMapper.toEntityList(data.results);
    });
  }

  @override
  Future<Result<TaskEntity>> createTask(CreateTaskRequestEntity request) {
    return asyncGuard(() async {
      final requestModel = CreateTaskRequestMapper.toModel(request);
      final requestBody = requestModel.toJson();
      final response = await _dataSource.createTask(requestBody);
      final TaskModel taskModel = TaskModel.fromJson(response.data);

      return TaskMapper.toEntity(taskModel);
    });
  }

  @override
  Future<Result<TaskEntity>> updateTask(TaskEntity task) {
    return asyncGuard(() async {
      final requestModel = TaskMapper.toModel(task);
      final requestBody = requestModel.toJson();
      final response = await _dataSource.updateTask(task.id ?? '', requestBody);
      final TaskModel taskModel = TaskModel.fromJson(response.data);
      return TaskMapper.toEntity(taskModel);
    });
  }

  @override
  Future<Result<List<CommentEntity>>> getComments(String taskId) {
    return asyncGuard(() async {
      final response = await _dataSource.getComments(taskId);
      final CommentResponseModel data = CommentResponseModel.fromJson(
        response.data,
      );
      return CommentMapper.toEntityList(data.results);
    });
  }

  @override
  Future<Result<CommentEntity>> addComment(AddCommentRequestEntity request) {
    return asyncGuard(() async {
      final requestBody = AddCommentRequestMapper.toModel(request);
      final response = await _dataSource.addComment(
        requestBody.taskId ?? '',
        requestBody.toJson(),
      );
      final CommentModel commentModel = CommentModel.fromJson(response.data);
      return CommentMapper.toEntity(commentModel);
    });
  }
}
