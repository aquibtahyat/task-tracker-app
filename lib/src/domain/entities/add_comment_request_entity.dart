class AddCommentRequestEntity {
  final String content;
  final String? taskId;

  const AddCommentRequestEntity({required this.content, this.taskId});
}
