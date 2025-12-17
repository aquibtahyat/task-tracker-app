class TimeTrackingEntity {
  final String? taskId;
  final int? inProgressSeconds;
  final String? sessionStartTime;

  const TimeTrackingEntity({
    this.taskId,
    this.inProgressSeconds,
    this.sessionStartTime,
  });

  bool isRunning() => sessionStartTime != null;

  int currentElapsedSeconds() {
    if (sessionStartTime == null) {
      return inProgressSeconds ?? 0;
    }

    final startTime = DateTime.parse(sessionStartTime!);
    final sessionSeconds = DateTime.now().difference(startTime).inSeconds;
    return (inProgressSeconds ?? 0) + sessionSeconds;
  }
}
