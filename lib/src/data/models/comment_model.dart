class CommentModel {
  final String? id;
  final String? postedUid;
  final String? content;
  final List<String>? uidsToNotify;
  final bool? isDeleted;
  final String? postedAt;

  CommentModel({
    this.id,
    this.postedUid,
    this.content,
    this.uidsToNotify,
    this.isDeleted,
    this.postedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String?,
      postedUid: json['postedUid'] as String?,
      content: json['content'] as String?,
      uidsToNotify: json['uidsToNotify'] as List<String>?,
      isDeleted: json['isDeleted'] as bool?,
      postedAt: json['postedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postedUid': postedUid,
      'content': content,
      'uidsToNotify': uidsToNotify,
      'isDeleted': isDeleted,
      'postedAt': postedAt,
    };
  }
}
