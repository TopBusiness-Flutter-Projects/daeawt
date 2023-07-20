import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// import 'package:screenshot_callback/screenshot_callback.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import 'package:daeawt/injector.dart' as injector;
import 'dart:developer' as developer;
import 'package:path/path.dart';

import 'core/utils/toast_message_method.dart';
// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/home/presentation/home_cubit/home_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/signup/cubit/signup_cubit.dart';


class Elmazoon extends StatefulWidget {
  const Elmazoon({Key? key}) : super(key: key);

  @override
  State<Elmazoon> createState() => _ElmazoonState();
}

class _ElmazoonState extends State<Elmazoon> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isThemes = false;
  String shortcut = 'no action set';

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event.index == 4) {
        toastMessage(
          'no_internet_connection'.tr(),
          context,
          color: AppColors.error,
        );
      } else if (event == 1 || event == 3) {
        toastMessage(
          'internet_connection'.tr(),
          context,
          color: AppColors.success,
        );
      }
      _updateConnectionStatus(event);
    });


  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(text);

    Preferences.instance.savedLang(
      EasyLocalization.of(context)!.locale.languageCode,
    );
    return
      MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => injector.serviceLocator<HomeCubit>(),
        ),

        BlocProvider(
          create: (_) => injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<SignupCubit>(),
        ),

       ],
       child:
      GetMaterialApp(

        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: appTheme(),
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.light(), // standard dark theme
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,

    ));
  }
}
