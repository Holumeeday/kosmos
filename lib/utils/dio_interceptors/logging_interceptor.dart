import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// A logging interceptor for Dio package
/// @author: Godwin Mathias

class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger();

  /// [LoggingInterceptor] is used to print logs during network requests.
  LoggingInterceptor();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    _logger.i('*** API Request - Start ***');

    _printKV('URI', options.uri);
    _printKV('METHOD', options.method);
    _logger.d('HEADERS:');
    options.headers.forEach((key, v) => _printKV(' - $key', v));
    _logger.d('BODY:');
    _printAll(options.data ?? '');

    _logger.i('*** API Request - End ***');

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('*** Api Error - Start ***');

    _logger.e('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      _logger.e('STATUS CODE: ${err.response?.statusCode?.toString()}');
    }
    _logger.e('$err');
    if (err.response != null) {
      _printKV('REDIRECT', err.response?.realUri ?? '');
      _logger.e('BODY:');
      _printAll(err.response?.data.toString());
    }

    _logger.e('*** Api Error - End ***');
    return handler.next(err);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    _logger.i('*** Api Response - Start ***');

    _printKV('URI', response.requestOptions.uri);
    _printKV('STATUS CODE', response.statusCode ?? '');
    _printKV('REDIRECT', response.isRedirect);
    _logger.d('BODY:');
    _printAll(response.data ?? '');

    _logger.i('*** Api Response - End ***');

    return handler.next(response);
  }

  void _printKV(String key, Object? v) {
    _logger.d('$key: $v');
  }

  void _printAll(dynamic msg) {
    msg.toString().split('\n').forEach(_logger.d);
  }
}
