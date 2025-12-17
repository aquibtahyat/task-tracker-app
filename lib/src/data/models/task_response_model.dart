import 'package:task_tracker_app/src/data/models/task_model.dart';

class TaskResponseModel {
  final List<TaskModel> results;

  TaskResponseModel({required this.results});

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskResponseModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => TaskModel.fromJson(e))
          .toList(),
    );
  }
}
