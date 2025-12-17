import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/core/base/use_case.dart';
import 'package:task_tracker_app/src/domain/entities/create_task_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/repositories/task_repository.dart';

@injectable
class CreateTaskUseCase
    implements UseCase<Result<TaskEntity>, CreateTaskRequestEntity> {
  final TaskRepository _taskRepository;

  CreateTaskUseCase(this._taskRepository);

  @override
  Future<Result<TaskEntity>> call(CreateTaskRequestEntity request) {
    return _taskRepository.createTask(request);
  }
}
