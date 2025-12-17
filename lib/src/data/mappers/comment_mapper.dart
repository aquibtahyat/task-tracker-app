import 'package:task_tracker_app/src/data/models/comment_model.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';

class CommentMapper {
  static CommentEntity toEntity(CommentModel comment) {
    return CommentEntity(
      id: comment.id,
      postedUid: comment.postedUid,
      content: comment.content,
      uidsToNotify: comment.uidsToNotify,
      isDeleted: comment.isDeleted,
      postedAt: comment.postedAt,
    );
  }

  static List<CommentEntity> toEntityList(List<CommentModel> list) {
    return list.map((e) => toEntity(e)).toList();
  }

  static CommentModel toModel(CommentEntity comment) {
    return CommentModel(
      id: comment.id,
      postedUid: comment.postedUid,
      content: comment.content,
      uidsToNotify: comment.uidsToNotify,
      isDeleted: comment.isDeleted,
      postedAt: comment.postedAt,
    );
  }
}
