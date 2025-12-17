import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/data/data_sources/cache/cache_service.dart';
import 'package:task_tracker_app/src/data/mappers/time_tracking_mapper.dart';
import 'package:task_tracker_app/src/data/models/time_tracking_model.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/entities/time_tracking_entity.dart';

@injectable
class TimeTrackerCubit extends Cubit<BaseState> {
  TimeTrackerCubit(this._cacheService) : super(InitialState());

  final CacheService _cacheService;
  Timer? _ticker;

  Future<void> retrieveData(List<TaskEntity> tasks) async {
    final List<TimeTrackingEntity> timers = [];

    for (var task in tasks) {
      if (task.id == null) continue;

      final json = _cacheService.get<Map<String, dynamic>>(
        '${CacheKey.timeTracking}_${task.id}',
      );

      if (json != null) {
        final model = TimeTrackingModel.fromJson(json);
        timers.add(TimeTrackingMapper.toEntity(model));
      } else {
        timers.add(
          TimeTrackingEntity(
            taskId: task.id,
            inProgressSeconds: 0,
            sessionStartTime: null,
          ),
        );
      }
    }

    emit(SuccessState(timers));

    if (timers.any((data) => data.isRunning())) {
      _startTicker();
    }
  }

  Future<void> updateTimer(String taskId, String? sessionStartTime) async {
    final timers = _getCurrentTimers();
    final currentData = _getTimerData(timers, taskId);

    int? elapsedSeconds = currentData?.inProgressSeconds ?? 0;
    if (sessionStartTime == null && currentData?.sessionStartTime != null) {
      elapsedSeconds = currentData!.currentElapsedSeconds();
    }

    final updatedData = TimeTrackingEntity(
      taskId: taskId,
      inProgressSeconds: elapsedSeconds,
      sessionStartTime: sessionStartTime,
    );

    final updatedTimers = timers
        .where((data) => data.taskId != taskId)
        .toList();
    updatedTimers.add(updatedData);

    emit(SuccessState(updatedTimers));
    await _saveToCache(taskId, updatedData);

    if (sessionStartTime != null) {
      _startTicker();
    } else if (!updatedTimers.any((data) => data.isRunning())) {
      _ticker?.cancel();
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final timers = _getCurrentTimers();
      if (timers.isNotEmpty) {
        final tickedTimers = timers
            .map(
              (data) => TimeTrackingEntity(
                taskId: data.taskId,
                inProgressSeconds: data.inProgressSeconds,
                sessionStartTime: data.sessionStartTime,
              ),
            )
            .toList();

        emit(SuccessState(tickedTimers));
      }
    });
  }

  TimeTrackingEntity? getTimer(String taskId) {
    final timers = _getCurrentTimers();
    return _getTimerData(timers, taskId);
  }

  List<TimeTrackingEntity> _getCurrentTimers() {
    final currentState = state;
    if (currentState is SuccessState) {
      return List<TimeTrackingEntity>.from(
        currentState.data as List<TimeTrackingEntity>? ?? [],
      );
    }
    return [];
  }

  TimeTrackingEntity? _getTimerData(
    List<TimeTrackingEntity> timers,
    String taskId,
  ) {
    try {
      return timers.firstWhere((data) => data.taskId == taskId);
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveToCache(String taskId, TimeTrackingEntity data) async {
    final model = TimeTrackingMapper.toModel(data);
    await _cacheService.save('${CacheKey.timeTracking}_$taskId', model.toJson());
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
