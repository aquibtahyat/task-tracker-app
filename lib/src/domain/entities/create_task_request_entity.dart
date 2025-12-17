class CreateTaskRequestEntity {
  final String? content;
  final String? description;
  final String? projectId;
  final String? sectionId;
  final String? parentId;
  final int? order;
  final List<String>? labels;
  final int? priority;
  final int? assigneeId;
  final String? dueString;
  final String? dueDate;
  final String? dueDatetime;
  final String? dueLang;
  final int? duration;
  final String? durationUnit;
  final DateTime? deadlineDate;

  const CreateTaskRequestEntity({
    this.content,
    this.description,
    this.projectId,
    this.sectionId,
    this.parentId,
    this.order,
    this.labels,
    this.priority,
    this.assigneeId,
    this.dueString,
    this.dueDate,
    this.dueDatetime,
    this.dueLang,
    this.duration,
    this.durationUnit,
    this.deadlineDate,
  });
}
