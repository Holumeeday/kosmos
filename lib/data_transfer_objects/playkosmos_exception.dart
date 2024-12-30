import 'package:playkosmos_v3/enums/enums.dart';

class PlaykosmosException implements Exception {
  final String message;
  final ErrorEnum error;

  PlaykosmosException({
    required this.error,
    String? message,
  }) : message = message ?? error.detail;

  @override
  String toString() => message;
}
