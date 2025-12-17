import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/core/base/use_case.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/repositories/task_repository.dart';

@injectable
class UpdateTaskUseCase implements UseCase<Result<TaskEntity>, TaskEntity> {
  final TaskRepository _taskRepository;

  UpdateTaskUseCase(this._taskRepository);

  @override
  Future<Result<TaskEntity>> call(TaskEntity request) {
    return _taskRepository.updateTask(request);
  }
}
