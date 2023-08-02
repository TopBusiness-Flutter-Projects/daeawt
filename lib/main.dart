import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:daeawt/injector.dart' as injector;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'firebase_options.dart';



final locator = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await PushNotificationService.instance.initialise();
  //await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE)
  //     .then((value) {
  //   print('************************************************');
  //   print(value);
  //   print('************************************************');
  // });

  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  //AppColors.getPrimaryColor();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // await pushNotificationService!.initialise();
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  await injector.setup();
  Bloc.observer = AppBlocObserver();

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) =>
       DevicePreview(builder: (context) =>  EasyLocalization(
        supportedLocales: [Locale('ar', ''), Locale('en', '')],
        path: 'assets/lang',
        saveLocale: true,
        startLocale: Locale('ar', ''),
        fallbackLocale: Locale('ar', ''),
        child: Phoenix(child: const Elmazoon()),
      ),),
    ),

  );
}

