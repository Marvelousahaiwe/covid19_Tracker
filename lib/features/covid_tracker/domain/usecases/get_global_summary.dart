import '../entities/covid_summary.dart';
import '../repositories/covid_repository.dart';

class GetGlobalSummary {
  final CovidRepository _repository;

  const GetGlobalSummary(this._repository);

  Future<CovidSummary> call() => _repository.getGlobalSummary();
}
