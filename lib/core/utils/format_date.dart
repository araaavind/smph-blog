import 'package:intl/intl.dart';

String formatDate(DateTime dateTime, String format) {
  return DateFormat(format).format(dateTime);
}
