import 'package:intl/intl.dart';

class DateFormatter {
  /// Format a date string from database (ISO 8601) to a readable format
  /// Example: "2026-01-01 22:56:58.826297+00" -> "January 1, 2026 at 10:56 PM"
  static String formatDateTime(String? dateString, {String format = 'MMMM d, yyyy \'at\' h:mm a'}) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }

    try {
      // Parse the ISO 8601 date string
      final dateTime = DateTime.parse(dateString);
      
      // Format using intl package
      return DateFormat(format).format(dateTime.toLocal());
    } catch (e) {
      // If parsing fails, return the original string
      return dateString;
    }
  }

  /// Format date only (without time)
  /// Example: "2026-01-01 22:56:58.826297+00" -> "January 1, 2026"
  static String formatDate(String? dateString) {
    return formatDateTime(dateString, format: 'MMMM d, yyyy');
  }

  /// Format time only
  /// Example: "2026-01-01 22:56:58.826297+00" -> "10:56 PM"
  static String formatTime(String? dateString) {
    return formatDateTime(dateString, format: 'h:mm a');
  }

  /// Format as relative time (e.g., "2 hours ago", "3 days ago")
  static String formatRelative(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }

    try {
      final dateTime = DateTime.parse(dateString).toLocal();
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 365) {
        final years = (difference.inDays / 365).floor();
        return '$years ${years == 1 ? 'year' : 'years'} ago';
      } else if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '$months ${months == 1 ? 'month' : 'months'} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
    }
  }

  /// Format as short date (e.g., "01/01/2026")
  static String formatShortDate(String? dateString) {
    return formatDateTime(dateString, format: 'MM/dd/yyyy');
  }

  /// Format as long date with time (e.g., "Wednesday, January 1, 2026 at 10:56 PM")
  static String formatLongDateTime(String? dateString) {
    return formatDateTime(dateString, format: 'EEEE, MMMM d, yyyy \'at\' h:mm a');
  }
}

