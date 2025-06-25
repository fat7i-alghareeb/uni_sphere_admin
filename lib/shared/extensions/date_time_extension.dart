// 📦 Package imports:
import 'package:intl/intl.dart';

import '../imports/imports.dart';

// 🌎 Project imports:

extension DateConverter on String {
  String fullDate() {
    final dateTime = DateTime.parse(this);
    final date = DateFormat('yyyy-MM-dd', 'en-us').format(dateTime.toLocal());
    final time = DateFormat('hh:mm', 'en-us').format(dateTime.toLocal());
    final status = DateFormat('a', 'en-us').format(dateTime.toLocal());
    return '($time$status) $date';
  }

  String date() {
    final dateTime = DateTime.parse(this);
    final date =
        DateFormat('EEE d, MMM yyyy', 'en-us').format(dateTime.toLocal());
    return date;
  }

  String time() {
    final dateTime = DateTime.parse(this);
    final time = DateFormat('HH:mm', 'en-us').format(dateTime.toLocal());
    return time;
  }

  String timeAmPm() {
    final dateTime = DateTime.parse(this);
    final formattedTime =
        DateFormat('h:mm a', 'en_US').format(dateTime.toLocal());
    return formattedTime.toLowerCase();
  }

  String fromTimeSpan() {
    final time = this;
    final timeSplit = time.split(':');
    final converted =
        DateTime(2020, 0, 0, int.parse(timeSplit[0]), int.parse(timeSplit[1]));
    return converted.toString().time();
  }

  DateTime? toDate() {
    try {
      return DateFormat('yyyy-MM-dd').parse(this);
    } catch (e) {
      return null;
    }
  }

  DateTime? toTime() {
    try {
      final timeParts = split(':');
      if (timeParts.length >= 2) {
        final now = DateTime.now();
        return DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(timeParts[0]),
          int.parse(timeParts[1]),
          timeParts.length > 2 ? int.parse(timeParts[2]) : 0,
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Converts a date-time string (e.g., "2025-06-18 12:30:00") to DateTime
  /// Returns null if parsing fails
  DateTime? toDateTime() {
    try {
      if (contains(' ')) {
        final parts = split(' ');
        final datePart = parts[0];
        final timePart = parts[1];
        final date = datePart.toDate();
        final timeComponents = timePart.split(':');

        if (date != null && timeComponents.length >= 2) {
          return DateTime(
            date.year,
            date.month,
            date.day,
            int.parse(timeComponents[0]),
            int.parse(timeComponents[1]),
            timeComponents.length > 2 ? int.parse(timeComponents[2]) : 0,
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeRangeFormatter on DateTimeRange {
  String formatDateRange() {
    String startDate = DateFormat('yyyy/M/dd', 'en').format(start);
    String endDate = DateFormat('yyyy/M/dd', 'en').format(end);

    return "$startDate  -  $endDate";
  }
}

extension DateTimeExt on DateTime {
  String toDate() {
    return DateFormat('yyyy-MM-dd', 'en-us').format(this);
  }
}

extension DateTimeFormatter on DateTime {
  String get formatTime {
    return DateFormat('HH:mm a', 'en-us').format(this);
  }
}
