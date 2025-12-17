class CreateTaskRequestModel {
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

  CreateTaskRequestModel({
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

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'description': description,
      'project_id': projectId,
      'section_id': sectionId,
      'parent_id': parentId,
      'order': order,
      'labels': labels,
      'priority': priority,
      'assignee_id': assigneeId,
      'due_string': dueString,
      'due_date': dueDate,
      'due_datetime': dueDatetime,
      'due_lang': dueLang,
      'duration': duration,
      'duration_unit': durationUnit,
      'deadline_date': deadlineDate?.toIso8601String(),
    };
  }
}
