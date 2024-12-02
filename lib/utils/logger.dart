import 'package:logger/logger.dart';

/// Handle logging and pretty printing of logs and stacktrace to console
/// during development
///
/// @author: Godwin Mathias
final logger = Logger();

/// Logs error into the console with optional stacktrace usually in red color
void printE(dynamic error, [StackTrace? trace]) {
  logger.e(error, stackTrace: trace);
}

/// Informational logs
void printI(dynamic info, [StackTrace? trace]) {
  logger.i(info, stackTrace: trace);
}
