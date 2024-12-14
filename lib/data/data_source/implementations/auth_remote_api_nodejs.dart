import 'package:playkosmos_v3/data/data_source/interfaces/remote_api.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// This the authentication flow API created with NodeJS backend
///
/// @author: Godwin Mathias
class AuthRemoteApiNodeJs extends RemoteApi {
  AuthRemoteApiNodeJs()
      : super(
          client: Dio(options)
            ..interceptors.addAll(
              [
                LoggingInterceptor(),
              ],
            ),
        );

  /// The base option for all request
  static BaseOptions options = BaseOptions(
    baseUrl: EnvKeys.nodeJsBaseUrl,
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );
}
