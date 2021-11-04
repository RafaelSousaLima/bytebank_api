import 'dart:async';

import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/theme/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setUserIdentifier('teste123');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  runZonedGuarded<Future<void>>(() async {
    runApp(ByteBankApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType} > $change");
    super.onChange(bloc, change);
  }
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();
    return MaterialApp(
      theme: byteBankTheme,
      // home: Dashboard(),
      home: DashboardContainer(),
    );
  }
}
