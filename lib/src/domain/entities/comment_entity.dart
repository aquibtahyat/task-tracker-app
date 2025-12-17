class CommentEntity {
  final String? id;
  final String? postedUid;
  final String? content;
  final List<String>? uidsToNotify;
  final bool? isDeleted;
  final String? postedAt;

  const CommentEntity({
    this.id,
    this.postedUid,
    this.content,
    this.uidsToNotify,
    this.isDeleted,
    this.postedAt,
  });
}
