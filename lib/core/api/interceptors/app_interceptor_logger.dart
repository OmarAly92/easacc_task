import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

/// ====== Shared helpers ======

Future<String> _buildCurl(RequestOptions options) async {
  final components = <String>['curl -i'];

  // HTTP method
  final method = options.method.toUpperCase();
  if (method != 'GET') {
    components.add('-X $method');
  }

  // Headers (do not mutate options)
  options.headers.forEach((k, v) {
    if (k == 'Cookie') return; // often too large / not useful
    components.add('-H "${_esc('$k: ${v.toString()}')}"');
  });

  // Body
  final data = options.data;
  if (data != null) {
    if (data is FormData) {
      // Multipart: render fields + files with -F
      for (final entry in data.fields) {
        components.add('-F "${_esc('${entry.key}=${entry.value}')}"');
      }
      for (final entry in data.files) {
        final key = entry.key;
        final file = entry.value; // MultipartFile
        final filename = file.filename ?? 'file';
        final ct = file.contentType?.toString();

        // We don't have the original disk path in MultipartFile;
        // show a best-effort placeholder that illustrates what to run:
        // curl expects a *local* path after '@'.
        final value = ct == null ? '@$filename' : '@$filename;type=$ct';
        components.add('-F "${_esc('$key=$value')}"');
      }
    } else {
      // JSON / plain: -d "..."
      final body = _safeJsonForCurl(data);
      if (body.isNotEmpty) {
        components.add('-d "${_esc(body)}"');
      }
    }
  }

  // URL last
  components.add('"${options.uri.toString()}"');

  return components.join(' \\\n\t');
}

String _safeJsonForCurl(Object? data) {
  try {
    if (data is String) return data;
    return json.encode(data);
  } catch (_) {
    return data?.toString() ?? '';
  }
}

String _esc(String s) =>
    s.replaceAll(r'\', r'\\').replaceAll('"', r'\"').replaceAll('\n', r'\n');

/// ====== Talker-based interceptor ======

class AppInterceptorLogger extends TalkerDioLogger {
  AppInterceptorLogger({
    super.talker,
    super.settings = const TalkerDioLoggerSettings(),
    @Deprecated('No longer used; kept for backward compatibility.')
    this.convertFormData = true,
  });

  /// Deprecated: no longer used, we always format FormData correctly with -F.
  final bool convertFormData;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final curl = await _buildCurl(options);
      log(curl, name: 'CURL');
    } catch (err, st) {
      log(
        'unable to create a CURL representation of the requestOptions',
        name: 'CURL',
        error: err,
        stackTrace: st,
      );
    }
    // Optional: tiny delay to visually separate logs; safe to remove.
    await Future.delayed(const Duration(milliseconds: 50));
    super.onRequest(options, handler);
  }
}
