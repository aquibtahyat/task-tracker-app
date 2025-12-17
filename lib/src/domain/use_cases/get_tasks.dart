import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/core/base/use_case.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/repositories/task_repository.dart';

@injectable
class GetTasksUseCase implements UseCase<Result<List<TaskEntity>>, NoParams> {
  final TaskRepository _taskRepository;

  GetTasksUseCase(this._taskRepository);

  @override
  Future<Result<List<TaskEntity>>> call(NoParams params) {
    return _taskRepository.getTasks();
  }
}
