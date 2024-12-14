import 'package:dio/dio.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

mixin ErrorHandlingMixin {
  void handleError(exception) {
    if (exception is DioException) {
      if (exception.response?.statusCode != null) {
        switch (exception.response!.statusCode!) {
          case >= 400 && < 500:
            Map<String, dynamic> data = exception.response?.data;
            throw PlaykosmosException(
              error: ErrorEnum.responseError,
              message: GenericResponse.fromJson(data).message,
            );
          case >= 500:
            throw PlaykosmosException(error: ErrorEnum.unavailable);
          default:
            throw PlaykosmosException(error: ErrorEnum.unknown);
        }
      } else {
        switch (exception.type) {
          case DioExceptionType.connectionTimeout:
            throw PlaykosmosException(error: ErrorEnum.timeout);
          case DioExceptionType.connectionError:
            throw PlaykosmosException(error: ErrorEnum.connection);
          case DioExceptionType.cancel:
            throw PlaykosmosException(error: ErrorEnum.cancel);
          default:
            throw PlaykosmosException(error: ErrorEnum.unknown);
        }
      }
    } else {
      throw PlaykosmosException(error: ErrorEnum.unknown);
    }
  }
}
