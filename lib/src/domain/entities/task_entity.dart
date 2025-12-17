import 'package:task_tracker_app/src/domain/enums/task_type.dart';

class TaskEntity {
  final String? userId;
  final String? id;
  final String? projectId;
  final String? sectionId;
  final String? parentId;
  final String? addedByUid;
  final String? assignedByUid;
  final String? responsibleUid;
  final List<String>? labels;
  final Duration? duration;
  final bool? checked;
  final bool? isDeleted;
  final String? addedAt;
  final String? completedAt;
  final String? completedByUid;
  final String? updatedAt;
  final int? priority;
  final int? childOrder;
  final String? content;
  final String? description;
  final int? noteCount;
  final int? dayOrder;
  final bool? isCollapsed;

  const TaskEntity({
    this.userId,
    this.id,
    this.projectId,
    this.sectionId,
    this.parentId,
    this.addedByUid,
    this.assignedByUid,
    this.responsibleUid,
    this.labels,
    this.duration,
    this.checked,
    this.isDeleted,
    this.addedAt,
    this.completedAt,
    this.completedByUid,
    this.updatedAt,
    this.priority,
    this.childOrder,
    this.content,
    this.description,
    this.noteCount,
    this.dayOrder,
    this.isCollapsed,
  });

  TaskEntity copyWith({
    String? userId,
    String? id,
    String? projectId,
    String? sectionId,
    String? parentId,
    String? addedByUid,
    String? assignedByUid,
    String? responsibleUid,
    List<String>? labels,
    Duration? duration,
    bool? checked,
    bool? isDeleted,
    String? addedAt,
    String? completedAt,
    String? completedByUid,
    String? updatedAt,
    int? priority,
    int? childOrder,
    String? content,
    String? description,
    int? noteCount,
    int? dayOrder,
    bool? isCollapsed,
  }) {
    return TaskEntity(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      addedByUid: addedByUid ?? this.addedByUid,
      assignedByUid: assignedByUid ?? this.assignedByUid,
      responsibleUid: responsibleUid ?? this.responsibleUid,
      labels: labels ?? this.labels,
      duration: duration ?? this.duration,
      checked: checked ?? this.checked,
      isDeleted: isDeleted ?? this.isDeleted,
      addedAt: addedAt ?? this.addedAt,
      completedAt: completedAt ?? this.completedAt,
      completedByUid: completedByUid ?? this.completedByUid,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
      childOrder: childOrder ?? this.childOrder,
      content: content ?? this.content,
      description: description ?? this.description,
      noteCount: noteCount ?? this.noteCount,
      dayOrder: dayOrder ?? this.dayOrder,
      isCollapsed: isCollapsed ?? this.isCollapsed,
    );
  }

  TaskType getCurrentLabel() {
    if (labels == null || labels!.isEmpty) {
      return TaskType.todo;
    }
    if (labels!.contains(TaskType.inProgress.type)) {
      return TaskType.inProgress;
    }
    if (labels!.contains(TaskType.done.type)) {
      return TaskType.done;
    }
    return TaskType.todo;
  }
}
