import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

import 'firebase_options.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // print("Background message ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));

  await Hive.initFlutter();

  await FirebaseAppCheck.instance.activate();
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  await Jiffy.locale("id");

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, _) => GetMaterialApp(
        title: 'Mapalus',
        theme: appThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        getPages: Routes.getRoutes(),
        builder: (context, widget) {
          // ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: widget!,
          );
        },
      ),
    );
  }
}