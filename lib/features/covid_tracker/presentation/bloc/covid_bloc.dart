import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_global_summary.dart';
import '../../domain/usecases/get_historical_data.dart';
import 'covid_event.dart';
import 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  final GetGlobalSummary _getGlobalSummary;
  final GetHistoricalData _getHistoricalData;

  CovidBloc({
    required GetGlobalSummary getGlobalSummary,
    required GetHistoricalData getHistoricalData,
  })  : _getGlobalSummary = getGlobalSummary,
        _getHistoricalData = getHistoricalData,
        super(const CovidInitial()) {
    on<LoadCovidData>(_onLoad);
    on<RefreshCovidData>(_onRefresh);
  }

  Future<void> _onLoad(LoadCovidData event, Emitter<CovidState> emit) async {
    emit(const CovidLoading());
    await _fetchAndEmit(emit);
  }

  Future<void> _onRefresh(
      RefreshCovidData event, Emitter<CovidState> emit) async {
    if (state is! CovidLoaded) {
      emit(const CovidLoading());
    }
    await _fetchAndEmit(emit);
  }

  Future<void> _fetchAndEmit(Emitter<CovidState> emit) async {
    try {
      final results = await Future.wait([
        _getGlobalSummary(),
        _getHistoricalData(),
      ]);

      emit(CovidLoaded(
        summary: results[0] as dynamic,
        historicalData: results[1] as dynamic,
        fetchedAt: DateTime.now(),
      ));
    } catch (e) {
      emit(CovidError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
