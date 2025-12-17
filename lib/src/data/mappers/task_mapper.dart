import 'package:task_tracker_app/src/data/models/task_model.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';

class TaskMapper {
  static TaskEntity toEntity(TaskModel task) {
    return TaskEntity(
      userId: task.userId,
      id: task.id,
      projectId: task.projectId,
      sectionId: task.sectionId,
      parentId: task.parentId,
      addedByUid: task.addedByUid,
      assignedByUid: task.assignedByUid,
      responsibleUid: task.responsibleUid,
      labels: task.labels,
      duration: task.duration,
      checked: task.checked,
      isDeleted: task.isDeleted,
      addedAt: task.addedAt,
      completedAt: task.completedAt,
      completedByUid: task.completedByUid,
      updatedAt: task.updatedAt,
      priority: task.priority,
      childOrder: task.childOrder,
      content: task.content,
      description: task.description,
      noteCount: task.noteCount,
      dayOrder: task.dayOrder,
      isCollapsed: task.isCollapsed,
    );
  }

  static List<TaskEntity> toEntityList(List<TaskModel> list) {
    return list.map((e) => toEntity(e)).toList();
  }

  static TaskModel toModel(TaskEntity task) {
    return TaskModel(
      userId: task.userId,
      id: task.id,
      projectId: task.projectId,
      sectionId: task.sectionId,
      parentId: task.parentId,
      addedByUid: task.addedByUid,
      assignedByUid: task.assignedByUid,
      responsibleUid: task.responsibleUid,
      labels: task.labels,
      duration: task.duration,
      checked: task.checked,
      isDeleted: task.isDeleted,
      addedAt: task.addedAt,
      completedAt: task.completedAt,
      completedByUid: task.completedByUid,
      updatedAt: task.updatedAt,
      priority: task.priority,
      childOrder: task.childOrder,
      content: task.content,
      description: task.description,
      noteCount: task.noteCount,
      dayOrder: task.dayOrder,
      isCollapsed: task.isCollapsed,
    );
  }
}
