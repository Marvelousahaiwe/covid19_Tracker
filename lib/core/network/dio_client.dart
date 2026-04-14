import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  DioClient._();

  static final DioClient _instance = DioClient._();
  static DioClient get instance => _instance;

  late final Dio _dio = _buildDio();

  Dio get dio => _dio;

  Dio _buildDio() => Dio(
        BaseOptions(
          connectTimeout:
              const Duration(milliseconds: ApiConstants.timeoutMs),
          receiveTimeout:
              const Duration(milliseconds: ApiConstants.timeoutMs),
          headers: const {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
}

String dioErrorMessage(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return 'Connection timed out. Please check your internet and try again.';
    case DioExceptionType.connectionError:
      return 'No internet connection. Please try again.';
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode ?? 0;
      return 'Server error ($code). Please try again later.';
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}
