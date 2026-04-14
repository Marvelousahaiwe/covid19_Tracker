class CovidSummary {
  final int confirmed;
  final int active;
  final int recovered;
  final int deaths;
  final DateTime updated;

  const CovidSummary({
    required this.confirmed,
    required this.active,
    required this.recovered,
    required this.deaths,
    required this.updated,
  });

  double get activePercent =>
      confirmed > 0 ? (active / confirmed) * 100 : 0;

  double get recoveredPercent =>
      confirmed > 0 ? (recovered / confirmed) * 100 : 0;

  double get deathsPercent =>
      confirmed > 0 ? (deaths / confirmed) * 100 : 0;
}
