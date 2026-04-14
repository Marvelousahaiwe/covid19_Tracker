import '../../domain/entities/covid_summary.dart';

class CovidSummaryModel extends CovidSummary {
  const CovidSummaryModel({
    required super.confirmed,
    required super.active,
    required super.recovered,
    required super.deaths,
    required super.updated,
  });

  factory CovidSummaryModel.fromJson(Map<String, dynamic> json) {
    return CovidSummaryModel(
      confirmed: (json['cases'] as num).toInt(),
      active: (json['active'] as num).toInt(),
      recovered: (json['recovered'] as num).toInt(),
      deaths: (json['deaths'] as num).toInt(),
      updated: DateTime.fromMillisecondsSinceEpoch(
        (json['updated'] as num).toInt(),
      ),
    );
  }
}
