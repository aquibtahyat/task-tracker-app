class TaskModel {
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

  TaskModel({
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

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      userId: json['userId'] as String?,
      id: json['id'] as String?,
      projectId: json['projectId'] as String?,
      sectionId: json['sectionId'] as String?,
      parentId: json['parentId'] as String?,
      addedByUid: json['addedByUid'] as String?,
      assignedByUid: json['assignedByUid'] as String?,
      responsibleUid: json['responsibleUid'] as String?,
      labels: (json['labels'] as List<dynamic>?)?.map((e) {
        if (e is String) {
          return e;
        } else if (e is Map<String, dynamic>) {
          return (e['name'] ?? e['value'] ?? e.toString()) as String;
        }
        return e.toString();
      }).toList(),
      duration: json['duration'] != null
          ? Duration(milliseconds: json['duration'])
          : null,
      checked: json['checked'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      addedAt: json['addedAt'] as String?,
      completedAt: json['completed_at'] as String?,
      completedByUid: json['completedByUid'] as String?,
      updatedAt: json['updated_at'] as String?,
      priority: json['priority'] as int?,
      childOrder: json['childOrder'] as int?,
      content: json['content'] as String?,
      description: json['description'] as String?,
      noteCount: json['noteCount'] as int?,
      dayOrder: json['dayOrder'] as int?,
      isCollapsed: json['isCollapsed'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'projectId': projectId,
      'sectionId': sectionId,
      'parentId': parentId,
      'addedByUid': addedByUid,
      'assignedByUid': assignedByUid,
      'responsibleUid': responsibleUid,
      'labels': labels,
      'duration': duration?.inMilliseconds,
      'checked': checked,
      'isDeleted': isDeleted,
      'addedAt': addedAt,
      'completed_at': completedAt,
      'completedByUid': completedByUid,
      'updated_at': updatedAt,
      'priority': priority,
      'childOrder': childOrder,
      'content': content,
      'description': description,
      'noteCount': noteCount,
      'dayOrder': dayOrder,
      'isCollapsed': isCollapsed,
    };
  }
}
