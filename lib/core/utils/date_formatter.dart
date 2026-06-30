import 'package:intl/intl.dart';

/// Consistent date/time display across the app.
/// Centralized so "May 10, 2025" vs "5/10/25" is one decision, not ten.
class DateFormatter {
  DateFormatter._();

  static String toDisplayDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  static String toRelative(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return toDisplayDate(date);
  }

  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }
}
