import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/enums/enums.dart';

mixin ErrorHandlerMixin {
  /// Converts any error to a playkosmos exception
  PlaykosmosException convertToPlaykosmosException(dynamic error) {
    return (error is PlaykosmosException)
        ? error
        : PlaykosmosException(error: ErrorEnum.unknown);
  }

  /// Returns the response error message or [fallbackMessage]
  String getMessageFromExceptionOrFallback(
      dynamic error, String fallbackMessage) {
    final PlaykosmosException exception = convertToPlaykosmosException(error);
    return (exception.error == ErrorEnum.responseError)
        ? exception.message
        : fallbackMessage;
  }

  /// If its a passive or actionable exception
  bool isExceptionPassive(dynamic error) {
    final PlaykosmosException exception = convertToPlaykosmosException(error);
    bool isPassive;
    switch (exception.error) {
      case ErrorEnum.timeout:
      case ErrorEnum.connection:
      case ErrorEnum.cancel:
        isPassive = false;
        break;
      case ErrorEnum.unavailable:
      case ErrorEnum.unknown:
      case ErrorEnum.responseError:
        isPassive = true;
    }
    return isPassive;
  }
}
