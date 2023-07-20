import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/features/contact_us/presentation/screens/contact_us.dart';
import 'package:daeawt/features/details/presentation/screens/details_screen.dart';
import 'package:daeawt/features/edit_profile/presentation/screens/edit_profile.dart';
import 'package:daeawt/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:daeawt/features/google_map/presentation/screens/google_map.dart';
import 'package:daeawt/features/home/presentation/screens/add_invitation2.dart';
import 'package:daeawt/features/home/presentation/screens/add_invitation_screen.dart';
import 'package:daeawt/features/home/presentation/screens/home_screen.dart';
import 'package:daeawt/features/home/presentation/screens/notification_screen.dart';
import 'package:daeawt/features/home/presentation/screens/profile_screen.dart';
import 'package:daeawt/features/home/presentation/screens/scan_screen.dart';
import 'package:daeawt/features/login/presentation/screens/login_screen.dart';
import 'package:daeawt/features/new_password/presentation/screens/new_password_screen.dart';
import 'package:daeawt/features/otp/presentation/screens/otp_screen.dart';
import 'package:daeawt/features/reminder/presentation/screens/reminder_screen.dart';
import 'package:daeawt/features/signup/presentation/screens/signup.dart';
import 'package:daeawt/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../features/home/models/home_list_item_model.dart';
import '../../features/home/presentation/screens/add_invitation3.dart';
import '../../features/home/presentation/screens/add_invitation4.dart';
import '../../features/home/presentation/screens/add_invitation5.dart';

class Routes{
  //all strings
  static const String initialRoute = "/";
  static const String loginRoute = "/loginScreen";
  static const String signUpRoute = "/signUpScreen";
  static const String forgotPasswordRoute = "/forgotPasswordScreen";
  static const String otpRoute = "/otpScreen";
  static const String newPasswordRoute = "/newPasswordScreen";
  static const String homeRoute = "/homeScreen";
  static const String addInvitationRoute = "/addInvitationScreen";
  static const String notificationRoute = "/notificationScreen";
  static const String profileRoute = "/profileScreen";
  static const String scanRoute = "/scanScreen";
  static const String editProfileRoute = "/editProfileScreen";
  static const String contactUsRoute = "/contactUsScreen";
  static const String addInvitationStep2Route = "/addInvitationStep2sScreen";
  static const String addInvitationStep3Route = "/addInvitationStep3Screen";
  static const String addInvitationStep4Route = "/addInvitationStep4Screen";
  static const String addInvitationStep5Route = "/addInvitationStep5Screen";
  static const String googleMapRoute = "/googleMapScreen";
  static const String detailsRoute = "/detailsScreen";
  static const String reminderRoute = "/reminderScreen";
}

class AppRoutes{
  //on generate route
 static Route onGenerateRoute( RouteSettings settings){
  switch(settings.name){

    case Routes.initialRoute:
      return MaterialPageRoute(builder: (context) =>const SplashScreen(),);

    case Routes.loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen(),);

    case Routes.signUpRoute:
      return MaterialPageRoute(builder: (context) =>  SignUpScreen(),);

    case Routes.forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(),);

    case Routes.otpRoute:
      return MaterialPageRoute(builder: (context) => const OtpScreen(),);

    case Routes.newPasswordRoute:
      return MaterialPageRoute(builder: (context) => const NewPasswordScreen(),);

    case Routes.homeRoute:
      return MaterialPageRoute(builder: (context) =>  HomeScreen(),);

    case Routes.addInvitationRoute:
      return MaterialPageRoute(builder: (context) =>   AddInvitationScreen(),);

    case Routes.notificationRoute:
      return MaterialPageRoute(builder: (context) =>  const NotificationScreen(),);

    case Routes.profileRoute:
      return MaterialPageRoute(builder: (context) =>  const ProfileScreen(),);

    case Routes.scanRoute:
      return MaterialPageRoute(builder: (context) =>  const ScanScreen(),);

    case Routes.editProfileRoute:
      return MaterialPageRoute(builder: (context) =>  const EditProfileScreen(),);

    case Routes.contactUsRoute:
      return MaterialPageRoute(builder: (context) =>  const ContactUsScreen(),);

    case Routes.addInvitationStep2Route:
      return MaterialPageRoute(builder: (context) =>   const AddInvitationStepTwoScreen(),);

    case Routes.addInvitationStep3Route:
      return MaterialPageRoute(builder: (context) =>   const AddInvitationStepThreeScreen(),);

    case Routes.addInvitationStep4Route:
      return MaterialPageRoute(builder: (context) =>   const AddInvitationStepFourScreen(),);

    case Routes.addInvitationStep5Route:
      return MaterialPageRoute(builder: (context) =>   const AddInvitationStepFiveScreen(),);

    case Routes.detailsRoute:
      var homeListModel = settings.arguments as HomeListItemModel;
      return MaterialPageRoute(builder: (context) =>    DetailsScreen(homeListItemModel:homeListModel ),);



    case Routes.googleMapRoute:
      return MaterialPageRoute(builder: (context) =>   const GoogleMapScreen(),);

    case Routes.reminderRoute:
      return MaterialPageRoute(builder: (context) =>   const ReminderScreen(),);

    default:
      return undefinedRoute();
  }
  }
  static Route<dynamic> undefinedRoute(){
   return MaterialPageRoute(
     builder: (context) {
     return const Scaffold(
       body: Center(child: Text(AppStrings.noRouteFound),),
     );
   },);
  }
}
