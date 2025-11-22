import 'package:equatable/equatable.dart';
import 'package:easacc_task/core/error_handling/failures/failure.dart';

class GlobalResponse<T> extends Equatable {
  final String? status;
  final String? message;
  final T? data;

  const GlobalResponse({this.status, this.message, this.data});

  factory GlobalResponse.fromJson(
    dynamic json, {
    dynamic Function(Map<String, dynamic>)? fromJsonT,
    bool withDataKey = true,
    String key = 'data',
    // bool isList = false,
  }) {
    try {
      final rawData = withDataKey ? json[key] : json;
      final parsedData = fromJsonT == null
          ? rawData
          // isList
          //     ? List.from((rawData as List).map((e) => fromJsonT(e)).toList())
          : fromJsonT(rawData);

      return GlobalResponse<T>(status: '', message: json['message'] as String?, data: parsedData);
    } catch (error, stackTrace) {
      throw MappingFailure(error: error, stacktrace: stackTrace);
    }
  }

  @override
  List<Object?> get props => [status, message, data];
}
