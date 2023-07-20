import 'package:daeawt/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(
      EasyLocalization(
        supportedLocales: L10n.all,
        fallbackLocale: L10n.all[0],
          path: 'assets/lang',
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
              return HomeCubit();
            },)
          ],
            child: const MyApp()),
      ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      localizationsDelegates:context.localizationDelegates ,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Cairo"
      ),
         onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}


class L10n{
  static final all = [
    const Locale('en'),
    const Locale('ar'),

  ];
}

