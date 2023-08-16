
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:daeawt/features/add_person/presentation/cubit/add_person_cubit.dart';
import 'package:daeawt/features/confirmed/cubit/confirmed_cubit.dart';
import 'package:daeawt/features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'package:daeawt/features/details/cubit/detials_cubit.dart';
import 'package:daeawt/features/failed/presentation/cubit/faild_cubit.dart';
import 'package:daeawt/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:daeawt/features/invited/presentation/cubit/invited_cubit.dart';
import 'package:daeawt/features/not_sent/cubit/notsent_cubit.dart';
import 'package:daeawt/features/new_password/presentation/cubit/new_password_cubit.dart';
import 'package:daeawt/features/otp/presentation/cubit/otp_cubit.dart';
import 'package:daeawt/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:daeawt/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:daeawt/features/scan/cubit/scan_cubit.dart';
import 'package:daeawt/features/scanned/presentation/cubit/scanned_cubit.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/apology/cubit/appology_cubit.dart';
import 'features/edit_profile/cubit/edit_profile_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/messages/presentation/cubit/messages_cubit.dart';
import 'features/notifications/cubit/notifications_cubit.dart';
import 'features/signup/cubit/signup_cubit.dart';
import 'features/waiting/cubit/waiting_cubit.dart';



final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////
  serviceLocator.registerFactory(
    () => HomeCubit(serviceLocator()),
  );


  serviceLocator.registerFactory(
    () => LoginCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ScanCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => SignupCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => MessagesCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => ScannedCubit(),
  );
  serviceLocator.registerFactory(
        () => ConfirmedCubit(),
  );
  serviceLocator.registerFactory(
        () => AppologyCubit(),
  );
  serviceLocator.registerFactory(
        () => NotsentCubit(),
  );
  serviceLocator.registerFactory(
        () => EditProfileCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => NotificationsCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => FaildCubit(),
  );
  serviceLocator.registerFactory(
        () => AddPersonCubit(),
  );
  serviceLocator.registerFactory(
        () => WaitingCubit(),
  );

  serviceLocator.registerFactory(
        () => ReminderCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => InvitedCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => AddInvitationCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => DetailsCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => ForgotPasswordCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => OtpCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => ProfileCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => NewPasswordCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => ContactUsCubit(serviceLocator()),
  );



  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(dioClient: serviceLocator()));

  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
