import '../entities/covid_summary.dart';
import '../entities/covid_daily_case.dart';

abstract class CovidRepository {
  Future<CovidSummary> getGlobalSummary();

  Future<List<CovidDailyCase>> getHistoricalData({int days = 8});
}
