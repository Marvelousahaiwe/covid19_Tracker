import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/covid_tracker/data/datasources/covid_remote_datasource.dart';
import 'features/covid_tracker/data/repositories/covid_repository_impl.dart';
import 'features/covid_tracker/domain/usecases/get_global_summary.dart';
import 'features/covid_tracker/domain/usecases/get_historical_data.dart';
import 'features/covid_tracker/presentation/bloc/covid_bloc.dart';
import 'features/covid_tracker/presentation/bloc/covid_event.dart';
import 'features/covid_tracker/presentation/screens/covid_dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.scaffoldBg,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const CovidTrackerApp());
}

class CovidTrackerApp extends StatelessWidget {
  const CovidTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = CovidRemoteDataSource();
    final repository = CovidRepositoryImpl(dataSource);
    final getGlobalSummary = GetGlobalSummary(repository);
    final getHistoricalData = GetHistoricalData(repository);

    return BlocProvider(
      create: (_) => CovidBloc(
        getGlobalSummary: getGlobalSummary,
        getHistoricalData: getHistoricalData,
      )..add(const LoadCovidData()),
      child: MaterialApp(
        title: 'COVID-19 Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const CovidDashboardScreen(),
      ),
    );
  }
}
