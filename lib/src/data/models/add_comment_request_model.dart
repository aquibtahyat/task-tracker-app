class AddCommentRequestModel {
  final String content;
  final String? taskId;

  AddCommentRequestModel({required this.content, this.taskId});

  Map<String, dynamic> toJson() {
    return {'content': content, 'task_id': taskId};
  }
}
