import 'package:easacc_task/core/error_handling/dio_error_handler/status_code.dart';
import 'package:easacc_task/core/error_handling/failures/failure.dart';

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  tooManyRequest,
  notFound,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  kDefault,
}

extension DataSourceExtension on DataSource {
  Failure<T> getFailure<T>(StackTrace stacktrace) {
    switch (this) {
      case DataSource.noContent:
        return ServerFailure(
          statusCode: StatusCode.noContent,
          error: ResponseMessage.noContent,
          stacktrace: stacktrace,
        );
      case DataSource.badRequest:
        return ServerFailure(
          statusCode: StatusCode.badRequest,
          error: ResponseMessage.badRequest,
          stacktrace: stacktrace,
        );
      case DataSource.forbidden:
        return ServerFailure(
          statusCode: StatusCode.forbidden,
          error: ResponseMessage.forbidden,
          stacktrace: stacktrace,
        );
      case DataSource.unauthorised:
        return ServerFailure(
          statusCode: StatusCode.unauthorised,
          error: ResponseMessage.unauthorised,
          stacktrace: stacktrace,
        );
      case DataSource.notFound:
        return ServerFailure(
          statusCode: StatusCode.notFound,
          error: ResponseMessage.notFound,
          stacktrace: stacktrace,
        );
      case DataSource.internalServerError:
        return ServerFailure(
          statusCode: StatusCode.internalServerError,
          error: ResponseMessage.internalServerError,
          stacktrace: stacktrace,
        );
      case DataSource.connectionTimeout:
        return ServerFailure(
          statusCode: StatusCode.connectionTimeout,
          error: ResponseMessage.connectionTimeout,
          stacktrace: stacktrace,
        );
      case DataSource.cancel:
        return ServerFailure(
          statusCode: StatusCode.cancel,
          error: ResponseMessage.cancel,
          stacktrace: stacktrace,
        );
      case DataSource.receiveTimeout:
        return ServerFailure(
          statusCode: StatusCode.receiveTimeout,
          error: ResponseMessage.receiveTimeout,
          stacktrace: stacktrace,
        );
      case DataSource.sendTimeout:
        return ServerFailure(
          statusCode: StatusCode.sendTimeout,
          error: ResponseMessage.sendTimeout,
          stacktrace: stacktrace,
        );
      case DataSource.noInternetConnection:
        return ServerFailure(
          statusCode: StatusCode.noInternetConnection,
          error: ResponseMessage.noInternetConnection,
          stacktrace: stacktrace,
        );
      case DataSource.tooManyRequest:
        return ServerFailure(
          statusCode: StatusCode.tooManyRequest,
          error: ResponseMessage.tooManyRequest,
          stacktrace: stacktrace,
        );
      case DataSource.cacheError:
        return ServerFailure(
          statusCode: StatusCode.cacheError,
          error: ResponseMessage.cacheError,
          stacktrace: stacktrace,
        );
      case DataSource.kDefault:
        return ServerFailure(
          statusCode: StatusCode.kDefault,
          error: ResponseMessage.kDefault,
          stacktrace: stacktrace,
        );
    }
  }
}

class ResponseMessage {
  static const String success = ErrorStrings.success;
  static const String noContent = ErrorStrings.success;
  static const String badRequest = ErrorStrings.badRequestError;
  static const String unauthorised = ErrorStrings.unauthorizedError;
  static const String forbidden = ErrorStrings.forbiddenError;
  static const String internalServerError = ErrorStrings.internalServerError;
  static const String notFound = ErrorStrings.notFoundError;

  /// local status message
  static const String connectionTimeout = ErrorStrings.timeoutError;
  static const String cancel = ErrorStrings.defaultError;
  static const String receiveTimeout = ErrorStrings.timeoutError;
  static const String sendTimeout = ErrorStrings.timeoutError;
  static const String cacheError = ErrorStrings.cacheError;
  static const String noInternetConnection = ErrorStrings.noInternetError;
  static const String kDefault = ErrorStrings.defaultError;
  static const String tooManyRequest = ErrorStrings.tooManyRequest;
}

class ErrorStrings {
  static const String badRequestError =
      'The request was unacceptable, often due to missing a required parameter.';
  static const String noContent = 'No content was returned.';
  static const String forbiddenError = 'Access to the requested resource is forbidden.';
  static const String unauthorizedError = 'Authentication credentials are missing or incorrect.';
  static const String notFoundError = 'The requested resource could not be found.';
  static const String conflictError = 'There was a conflict while processing the request.';
  static const String internalServerError = 'The server encountered an internal error_handling.';
  static const String unknownError = 'An unknown error_handling occurred.';
  static const String timeoutError = 'The request timed out while waiting for a response.';
  static const String defaultError = 'An error_handling occurred while processing the request.';
  static const String cacheError = 'There was an error_handling accessing cached data.';
  static const String noInternetError = 'No internet connection available.';
  static const String tooManyRequest = 'API request limit exceeded. Please try again later.';
  static const String success = 'The operation was successful.';
}
