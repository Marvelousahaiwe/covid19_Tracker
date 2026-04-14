import 'package:equatable/equatable.dart';

abstract class CovidEvent extends Equatable {
  const CovidEvent();

  @override
  List<Object?> get props => [];
}

class LoadCovidData extends CovidEvent {
  const LoadCovidData();
}

class RefreshCovidData extends CovidEvent {
  const RefreshCovidData();
}
