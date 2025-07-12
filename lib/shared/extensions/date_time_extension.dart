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

extension TimeSpanAmPm on String {
  /// Converts a time string (HH:mm:ss or HH:mm) to a user-friendly format with AM/PM
  String toAmPmTime() {
    try {
      final parts = split(":");
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final dt = DateTime(2020, 1, 1, hour, minute);
        return DateFormat('hh:mm a').format(dt);
      }
      return this;
    } catch (e) {
      return this;
    }
  }

  /// Formats announcement dates in a human-readable format
  /// Examples: "2 hours ago", "Yesterday", "3 days ago", "Dec 15, 2024"
  String toHumanReadableDate() {
    try {
      final dateTime = DateTime.parse(this);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          if (difference.inMinutes == 0) {
            return 'Just now';
          }
          return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
        }
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months month${months == 1 ? '' : 's'} ago';
      } else {
        // For dates older than a year, show the actual date
        return DateFormat('MMM d, yyyy').format(dateTime);
      }
    } catch (e) {
      // If parsing fails, return the original string
      return this;
    }
  }
}
