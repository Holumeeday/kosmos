import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Custom implementation of BlocObserver for tracking events, transitions, and errors
/// during development
///
/// @author: Godwin Mathias
class AppBlocObserver extends BlocObserver {
  // Method to generate log messages using maps
  Map<String, dynamic> _generateLogMessage(
      String prefix, Map<String, dynamic> details) {
    ; // Join the map entries into a string
    return {'Type': prefix, ...details};
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    final message = _generateLogMessage(
      '[Event]',
      {
        'Bloc': bloc.runtimeType,
        'Event': event,
      },
    );
    printI(message);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    final message = _generateLogMessage(
      '[Transition]',
      {
        'Bloc': bloc.runtimeType,
        'CurrentState': transition.currentState,
        'Event': transition.event,
        'NextState': transition.nextState,
      },
    );
    printI(message);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    final message = _generateLogMessage(
      '[Error]',
      {
        'Bloc': bloc.runtimeType,
        'Error': error,
        'StackTrace': stackTrace,
      },
    );
    printE(message, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    final message = _generateLogMessage(
      '[Change]',
      {
        'Bloc': bloc.runtimeType,
        'CurrentState': change.currentState,
        'NextState': change.nextState,
      },
    );
    printI(message);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    final message = _generateLogMessage(
      '[Create]',
      {
        'Bloc': bloc.runtimeType,
        'Status': 'Created',
      },
    );
    printI(message);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    final message = _generateLogMessage(
      '[Close]',
      {
        'Bloc': bloc.runtimeType,
        'Status': 'Closed',
      },
    );
    printI(message);
  }
}
