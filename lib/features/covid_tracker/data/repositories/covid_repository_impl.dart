import '../../domain/entities/covid_summary.dart';
import '../../domain/entities/covid_daily_case.dart';
import '../../domain/repositories/covid_repository.dart';
import '../datasources/covid_remote_datasource.dart';

class CovidRepositoryImpl implements CovidRepository {
  final CovidRemoteDataSource _dataSource;

  const CovidRepositoryImpl(this._dataSource);

  @override
  Future<CovidSummary> getGlobalSummary() =>
      _dataSource.fetchGlobalSummary();

  @override
  Future<List<CovidDailyCase>> getHistoricalData({int days = 8}) =>
      _dataSource.fetchHistoricalData(days: days);
}
