class TimeTrackingModel {
  final String? taskId;
  final int? inProgressSeconds;
  final String? sessionStartTime;

  const TimeTrackingModel({
    this.taskId,
    this.inProgressSeconds,
    this.sessionStartTime,
  });

  Map<String, dynamic> toJson() => {
    'taskId': taskId,
    'inProgressSeconds': inProgressSeconds,
    'sessionStartTime': sessionStartTime,
  };

  factory TimeTrackingModel.fromJson(Map<String, dynamic> json) =>
      TimeTrackingModel(
        taskId: json['taskId'] as String?,
        inProgressSeconds: json['inProgressSeconds'] as int?,
        sessionStartTime: json['sessionStartTime'] as String?,
      );

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
