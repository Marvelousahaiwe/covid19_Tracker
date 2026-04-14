import 'package:equatable/equatable.dart';
import '../../domain/entities/covid_summary.dart';
import '../../domain/entities/covid_daily_case.dart';

abstract class CovidState extends Equatable {
  const CovidState();

  @override
  List<Object?> get props => [];
}

class CovidInitial extends CovidState {
  const CovidInitial();
}

class CovidLoading extends CovidState {
  const CovidLoading();
}

class CovidLoaded extends CovidState {
  final CovidSummary summary;
  final List<CovidDailyCase> historicalData;
  final DateTime fetchedAt;

  const CovidLoaded({
    required this.summary,
    required this.historicalData,
    required this.fetchedAt,
  });

  @override
  List<Object?> get props => [summary, historicalData, fetchedAt];
}

class CovidError extends CovidState {
  final String message;

  const CovidError(this.message);

  @override
  List<Object?> get props => [message];
}
