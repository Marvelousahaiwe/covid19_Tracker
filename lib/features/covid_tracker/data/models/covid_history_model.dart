import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/covid_daily_case.dart';

class CovidHistoryModel {
  static List<CovidDailyCase> fromJson(Map<String, dynamic> json) {
    final rawCases = json['cases'] as Map<String, dynamic>;

    final entries = rawCases.entries.toList()
      ..sort((a, b) => _parseDate(a.key).compareTo(_parseDate(b.key)));

    final last8 = entries.length >= ApiConstants.historicalDays
        ? entries.sublist(entries.length - ApiConstants.historicalDays)
        : entries;

    final List<CovidDailyCase> result = [];

    for (int i = 1; i < last8.length; i++) {
      final prevCount = (last8[i - 1].value as num).toInt();
      final currCount = (last8[i].value as num).toInt();
      final delta = (currCount - prevCount).clamp(0, double.maxFinite).toInt();

      result.add(CovidDailyCase(
        date: _parseDate(last8[i].key),
        newCases: delta,
      ));
    }

    return result;
  }

  static DateTime _parseDate(String key) {
    final parts = key.split('/');
    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = 2000 + int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}

