import 'package:news_app/core/utils/extensions/date_extensions.dart';

extension StringDateExtensions on String {
  String toRelativeTime() {
    try {
      final date = DateTime.parse(this);
      return date.toRelativeTime();
    } catch (e) {
      return 'Unknown';
    }
  }
}
