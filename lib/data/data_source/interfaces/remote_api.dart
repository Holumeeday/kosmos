import 'dart:async';

import 'package:dio/dio.dart';
import 'package:playkosmos_v3/mixins/error_handling_mixin.dart';

export 'package:dio/dio.dart';

/// Used to monitor a network (either a send or a receive) progress
typedef NetworkProgress = void Function(int progress, int total);

/*
This class handles all the api calls and interacts with the network package
@author: Ugochukwu Umeh
*/
abstract class RemoteApi with ErrorHandlingMixin {
  RemoteApi({
    required Dio client,
  }) : _client = client;

  final Dio _client;

  ///A post request
  Future<Response> post(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
    ResponseType? responseType,
    NetworkProgress? onSendProgress,
    NetworkProgress? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    late Response response;
    try {
      response = await _client.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          responseType: responseType,
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      handleError(e);
    }
    return response;
  }

  /// A get request
  Future<Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
    ResponseType? responseType,
    NetworkProgress? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    late Response response;
    try {
      response = await _client.get(
        path,
        data: body,
        options: Options(
          headers: headers,
          responseType: responseType,
        ),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      handleError(e);
    }
    return response;
  }

  /// A download request
  Future<void> download(
    String path,
    String savePath, {
    required NetworkProgress onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Map<String, String>? headers,
    ResponseType? responseType,
  }) async {
    try {
      await _client.download(
        path,
        savePath,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: headers,
          responseType: responseType,
        ),
      );
    } catch (e) {
      handleError(e);
    }
  }

  ///A post request
  Future<Response> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
    ResponseType? responseType,
    NetworkProgress? onSendProgress,
    NetworkProgress? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    late Response response;
    try {
      response = await _client.delete(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          responseType: responseType,
        ),
        cancelToken: cancelToken,
      );
    } catch (e) {
      handleError(e);
    }
    return response;
  }
}
