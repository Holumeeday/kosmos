import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:playkosmos_v3/data/data_source/interfaces/remote_api.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// This the authentication flow API created with NodeJS backend
///
/// @author: Godwin Mathias
class AuthRemoteApiNodeJs extends RemoteApi {
  /// Cookies storage
  final CookiesStorage fCookStorage;

  AuthRemoteApiNodeJs({
    required this.fCookStorage,
  }) : super(
          client: Dio(options)
            ..interceptors.addAll(
              [
                LoggingInterceptor(),
                CookieManager(
                  PersistCookieJar(
                    storage: fCookStorage,
                  ),
                ),
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
