import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:e_health/features/covid_tracker/data/datasources/covid_remote_datasource.dart';
import 'package:e_health/features/covid_tracker/data/repositories/covid_repository_impl.dart';
import 'package:e_health/features/covid_tracker/domain/usecases/get_global_summary.dart';
import 'package:e_health/features/covid_tracker/domain/usecases/get_historical_data.dart';
import 'package:e_health/features/covid_tracker/presentation/bloc/covid_bloc.dart';
import 'package:e_health/features/covid_tracker/presentation/screens/covid_dashboard_screen.dart';
import 'package:e_health/core/theme/app_theme.dart';

void main() {
  testWidgets('CovidDashboardScreen renders without crashing',
      (WidgetTester tester) async {
    final dataSource = CovidRemoteDataSource();
    final repository = CovidRepositoryImpl(dataSource);
    final getGlobalSummary = GetGlobalSummary(repository);
    final getHistoricalData = GetHistoricalData(repository);

    await tester.pumpWidget(
      BlocProvider(
        create: (_) => CovidBloc(
          getGlobalSummary: getGlobalSummary,
          getHistoricalData: getHistoricalData,
        ),
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const CovidDashboardScreen(),
        ),
      ),
    );

    // Initial frame shows loading or dashboard — no crash expected.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
