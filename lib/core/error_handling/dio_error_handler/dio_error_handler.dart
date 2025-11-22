import 'package:dio/dio.dart';
import 'package:easacc_task/core/error_handling/dio_error_handler/api_error_handler_helper.dart';
import 'package:easacc_task/core/error_handling/failures/failure.dart';

extension DioErrorExtension on DioException {
  Failure<T> getFailure<T>(
    StackTrace stacktrace, {
    T Function(Map<String, dynamic>)? fromJsonValidationErrors,
  }) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectionTimeout.getFailure(stacktrace);
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure(stacktrace);
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure(stacktrace);
      case DioExceptionType.badResponse:
        if (response != null && response?.statusCode != null && response?.statusMessage != null) {
          return ServerFailure<T>(
            statusCode: response?.statusCode ?? 0,
            error: response?.data['message'] ?? '',
            message: response?.data['message'] ?? '',
            stacktrace: stacktrace,
            validationErrors: fromJsonValidationErrors?.call(response?.data['errors'] ?? {}),
          );
        } else {
          return DataSource.kDefault.getFailure(stacktrace);
        }
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure(stacktrace);
      default:
        return DataSource.kDefault.getFailure(stacktrace);
    }
  }
}
