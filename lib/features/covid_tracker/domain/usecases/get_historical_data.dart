import '../../../../core/constants/api_constants.dart';
import '../entities/covid_daily_case.dart';
import '../repositories/covid_repository.dart';

class GetHistoricalData {
  final CovidRepository _repository;

  const GetHistoricalData(this._repository);

  Future<List<CovidDailyCase>> call({
    int days = ApiConstants.historicalDays,
  }) =>
      _repository.getHistoricalData(days: days);
}
