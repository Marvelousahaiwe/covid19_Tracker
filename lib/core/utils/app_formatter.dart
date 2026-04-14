import 'package:intl/intl.dart';

abstract class AppFormatter {
  static final NumberFormat _compact =
      NumberFormat.compactLong(locale: 'en_US');
  static final NumberFormat _full =
      NumberFormat('#,###', 'en_US');
  static final DateFormat _chartDate = DateFormat('MMM d');

  static String compact(num value) => _compact.format(value);

  static String full(num value) => _full.format(value);

  static String chartDate(DateTime date) => _chartDate.format(date);

  static String percent(double value) =>
      '${value.toStringAsFixed(1)}%';
}
