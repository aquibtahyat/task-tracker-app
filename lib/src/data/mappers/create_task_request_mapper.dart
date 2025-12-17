import 'package:task_tracker_app/src/data/models/create_task_request_model.dart';
import 'package:task_tracker_app/src/domain/entities/create_task_request_entity.dart';

class CreateTaskRequestMapper {
  static CreateTaskRequestModel toModel(CreateTaskRequestEntity entity) {
    return CreateTaskRequestModel(
      content: entity.content,
      description: entity.description,
      projectId: entity.projectId,
      sectionId: entity.sectionId,
      parentId: entity.parentId,
      order: entity.order,
      labels: entity.labels,
      priority: entity.priority,
      assigneeId: entity.assigneeId,
      dueString: entity.dueString,
      dueDate: entity.dueDate,
      dueDatetime: entity.dueDatetime,
      dueLang: entity.dueLang,
      duration: entity.duration,
      durationUnit: entity.durationUnit,
      deadlineDate: entity.deadlineDate,
    );
  }
}
