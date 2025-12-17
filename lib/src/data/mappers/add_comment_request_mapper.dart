import 'package:task_tracker_app/src/data/models/add_comment_request_model.dart';
import 'package:task_tracker_app/src/domain/entities/add_comment_request_entity.dart';

class AddCommentRequestMapper {
  static AddCommentRequestModel toModel(AddCommentRequestEntity entity) {
    return AddCommentRequestModel(
      content: entity.content,
      taskId: entity.taskId,
    );
  }
}







