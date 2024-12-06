import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/app.dart';
import 'package:playkosmos_v3/bloc_observer.dart';
import 'package:playkosmos_v3/data/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize non secure storage repository
  final fNonSecureStorage =
      NonSecureStorage(storage: NonSecureSembastStorageImpl());
  // Load the database into memory
  await fNonSecureStorage.initDb();

  // Add a custom bloc observer
  Bloc.observer = AppBlocObserver();

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (_) => App(
      fNonSecureStorage: fNonSecureStorage,
    ),
  ));
}
