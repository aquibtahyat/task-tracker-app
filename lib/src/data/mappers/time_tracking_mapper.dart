import 'package:task_tracker_app/src/data/models/time_tracking_model.dart';
import 'package:task_tracker_app/src/domain/entities/time_tracking_entity.dart';

class TimeTrackingMapper {
  static TimeTrackingEntity toEntity(TimeTrackingModel model) {
    return TimeTrackingEntity(
      taskId: model.taskId,
      inProgressSeconds: model.inProgressSeconds,
      sessionStartTime: model.sessionStartTime,
    );
  }

  static List<TimeTrackingEntity> toEntityList(List<TimeTrackingModel> list) {
    return list.map((e) => toEntity(e)).toList();
  }

  static TimeTrackingModel toModel(TimeTrackingEntity entity) {
    return TimeTrackingModel(
      taskId: entity.taskId,
      inProgressSeconds: entity.inProgressSeconds,
      sessionStartTime: entity.sessionStartTime,
    );
  }

  static List<TimeTrackingModel> toModelList(List<TimeTrackingEntity> list) {
    return list.map((e) => toModel(e)).toList();
  }
}
