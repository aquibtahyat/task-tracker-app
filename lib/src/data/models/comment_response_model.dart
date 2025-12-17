import 'package:task_tracker_app/src/data/models/comment_model.dart';

class CommentResponseModel {
  final List<CommentModel> results;

  CommentResponseModel({required this.results});

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) {
    return CommentResponseModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e))
          .toList(),
    );
  }
}
