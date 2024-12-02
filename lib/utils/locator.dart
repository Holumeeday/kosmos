import 'package:get_it/get_it.dart';
import 'package:playkosmos_v3/services/services.dart';
import 'package:playkosmos_v3/utils/utils.dart';

GetIt locator = GetIt.instance;

// Register all global service inside this function
Future<void> setupLocator() async {
  // Initialize app non secure storage box
  final fAppPreference = AppPreferenceService(storage: SembastPreference());
  await fAppPreference.initDb();
  locator.registerLazySingleton(() => fAppPreference);

  locator.registerLazySingleton(() => ModalBottomSheetService());

  // Initialize authentication storage service
  locator.registerLazySingleton(() => AuthStorageService());

  // Router instance
  locator.registerLazySingleton(() => AppRoute());
}
