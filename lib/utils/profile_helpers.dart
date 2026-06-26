class ProfileHelpers {
  static String getWeekdayLabel(int weekday) {
    switch (weekday) {
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      case 7:
        return 'S';
      default:
        return '';
    }
  }

  static String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return 'Oct ${date.day}'; // You might want to format this dynamically in the future
    }
  }

  static String getCategoryDisplayName(dynamic category) {
    final categoryStr = category.toString().split('.').last;
    switch (categoryStr) {
      case 'urgentImportant':
        return 'Work';
      case 'notUrgentImportant':
        return 'Personal';
      case 'urgentNotImportant':
        return 'Admin';
      case 'notUrgentNotImportant':
        return 'Research';
      default:
        return 'Other';
    }
  }
}
