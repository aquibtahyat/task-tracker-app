import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(dateTimeString).toLocal();
      return DateFormat('MMMM d, h:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }
}
