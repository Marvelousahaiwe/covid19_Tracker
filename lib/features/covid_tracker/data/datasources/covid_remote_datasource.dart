import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/covid_summary_model.dart';
import '../models/covid_history_model.dart';
import '../../domain/entities/covid_summary.dart';
import '../../domain/entities/covid_daily_case.dart';

class CovidRemoteDataSource {
  final Dio _dio;

  CovidRemoteDataSource({Dio? dio})
      : _dio = dio ?? DioClient.instance.dio;

  Future<CovidSummary> fetchGlobalSummary() async {
    try {
      final response = await _dio.get(ApiConstants.globalSummary);
      return CovidSummaryModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(dioErrorMessage(e));
    }
  }

  Future<List<CovidDailyCase>> fetchHistoricalData({int days = 8}) async {
    try {
      final response = await _dio.get(
        ApiConstants.globalHistorical,
        queryParameters: {'lastdays': days},
      );
      return CovidHistoryModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(dioErrorMessage(e));
    }
  }
}
