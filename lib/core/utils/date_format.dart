import 'package:intl/intl.dart';

String dateFormatDDMMYYYY(DateTime dateTime) {
  final res = DateFormat('d MMM yyyy').format(dateTime);
  return res;
}
