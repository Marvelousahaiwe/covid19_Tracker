abstract class ApiConstants {
  static const String _baseUrl = 'https://disease.sh';

  static const String globalSummary = '$_baseUrl/v3/covid-19/all';

  static const String globalHistorical = '$_baseUrl/v2/historical/all';

  static const int historicalDays = 8;

  static const int timeoutMs = 15000;
}
