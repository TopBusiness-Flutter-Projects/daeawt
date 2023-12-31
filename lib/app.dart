import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:daeawt/features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'package:daeawt/features/details/cubit/detials_cubit.dart';
import 'package:daeawt/features/failed/presentation/cubit/faild_cubit.dart';
import 'package:daeawt/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:daeawt/features/messages/presentation/cubit/messages_cubit.dart';
import 'package:daeawt/features/not_sent/cubit/notsent_cubit.dart';
import 'package:daeawt/features/new_password/presentation/cubit/new_password_cubit.dart';
import 'package:daeawt/features/otp/presentation/cubit/otp_cubit.dart';
import 'package:daeawt/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:daeawt/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:daeawt/features/scan/cubit/scan_cubit.dart';
import 'package:daeawt/features/scanned/presentation/cubit/scanned_cubit.dart';
import 'package:daeawt/features/waiting/cubit/waiting_cubit.dart';
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

import 'features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'features/add_person/presentation/cubit/add_person_cubit.dart';
import 'features/apology/cubit/appology_cubit.dart';
import 'features/confirmed/cubit/confirmed_cubit.dart';
import 'features/edit_profile/cubit/edit_profile_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/invited/presentation/cubit/invited_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/notifications/cubit/notifications_cubit.dart';
import 'features/signup/cubit/signup_cubit.dart';

class Elmazoon extends StatefulWidget {
  const Elmazoon({Key? key}) : super(key: key);

  @override
  State<Elmazoon> createState() => _ElmazoonState();
}

class _ElmazoonState extends State<Elmazoon> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  //
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // bool isThemes = false;
  // String shortcut = 'no action set';
  //
  // @override
  // void initState() {
  //   super.initState();
  //   initConnectivity();
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen((event) {
  //     if (event.index == 4) {
  //       toastMessage(
  //         'no_internet_connection'.tr(),
  //         context,
  //         color: AppColors.error,
  //       );
  //     } else if (event == 1 || event == 3) {
  //       toastMessage(
  //         'internet_connection'.tr(),
  //         context,
  //         color: AppColors.success,
  //       );
  //     }
  //     _updateConnectionStatus(event);
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _connectivitySubscription.cancel();
  //   super.dispose();
  // }
  //
  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(text);

    Preferences.instance.savedLang(
      EasyLocalization.of(context)!.locale.languageCode,
    );
    return MultiBlocProvider(
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
          BlocProvider(
            create: (_) => injector.serviceLocator<DetailsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<AddInvitationCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<InvitedCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ReminderCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<MessagesCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ScanCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ScannedCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<WaitingCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<FaildCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<NotsentCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<AppologyCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ConfirmedCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ForgotPasswordCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<OtpCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ProfileCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<NewPasswordCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<AddPersonCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ContactUsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<EditProfileCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<NotificationsCubit>(),
          ),
        ],
        child: GetMaterialApp(
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: appTheme(),
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.light(),
          // standard dark theme
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ));
  }
}
