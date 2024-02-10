import 'package:dart_date/dart_date.dart';

getDate(DateTime date, String? locale) {
  return "${date.toLocalTime.format('yMd', locale ?? 'en')}   ${date.toLocalTime.format('jm', locale ?? 'en')}";
}
