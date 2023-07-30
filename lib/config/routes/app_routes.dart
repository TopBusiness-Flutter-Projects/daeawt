import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/features/add_new_contacts/presentation/screens/add_new_contacts.dart';
import 'package:daeawt/features/add_person/presentation/screens/add_person.dart';
import 'package:daeawt/features/apology/presentation/screens/apolory_screen.dart';
import 'package:daeawt/features/confirmed/presentation/screens/confirmed_screen.dart';
import 'package:daeawt/features/contact_us/presentation/screens/contact_us.dart';
import 'package:daeawt/features/details/presentation/screens/details_screen.dart';
import 'package:daeawt/features/edit_profile/presentation/screens/edit_profile.dart';
import 'package:daeawt/features/failed/presentation/screens/failed_screen.dart';
import 'package:daeawt/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:daeawt/features/google_map/presentation/screens/google_map.dart';
import 'package:daeawt/features/add_invitation/presentation/screens/add_invitation2.dart';
import 'package:daeawt/features/add_invitation/presentation/screens/add_invitation_screen.dart';
import 'package:daeawt/features/home/presentation/screens/home_screen.dart';
import 'package:daeawt/features/notifications/presentation/screens/notification_screen.dart';
import 'package:daeawt/features/profile/presentation/screens/profile_screen.dart';
import 'package:daeawt/features/scan/presenation/screens/scan_screen.dart';
import 'package:daeawt/features/invited/presentation/screens/invited_screen.dart';
import 'package:daeawt/features/login/presentation/screens/login_screen.dart';
import 'package:daeawt/features/messages/presentation/screens/messages_screen.dart';
import 'package:daeawt/features/new_password/presentation/screens/new_password_screen.dart';
import 'package:daeawt/features/not_sent/presentation/screens/not_sent_screen.dart';
import 'package:daeawt/features/otp/presentation/screens/otp_screen.dart';
import 'package:daeawt/features/reminder/presentation/screens/reminder_screen.dart';
import 'package:daeawt/features/scanned/presentation/screens/scanned_screen.dart';
import 'package:daeawt/features/send_new_contacts/presentation/screens/send_new_contacts.dart';
import 'package:daeawt/features/signup/presentation/screens/signup.dart';
import 'package:daeawt/features/splash/presentation/screens/splash_screen.dart';
import 'package:daeawt/features/waiting/presentation/screens/waiting_screen.dart';
import 'package:flutter/material.dart';

import '../../core/model/InvitationDataModel.dart';
import '../../features/add_invitation/presentation/screens/add_invitation3.dart';
import '../../features/add_invitation/presentation/screens/add_invitation4.dart';
import '../../features/add_invitation/presentation/screens/add_invitation5.dart';

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
  static const String invitedRoute = "/invitedScreen";
  static const String messagesRoute = "/messagesScreen";
  static const String addPersonRoute = "/addPersonScreen";
  static const String addNewContactsRoute = "/addNewContactsScreen";
  static const String sendNewContactsRoute = "/sendNewContactsScreen";
  static const String scannedRoute = "/scannedScreen";
  static const String confirmedRoute = "/confirmedScreen";
  static const String waitingRoute = "/waitingScreen";
  static const String apologyRoute = "/apologyScreen";
  static const String failedRoute = "/failedScreen";
  static const String notSentRoute = "/notSentScreen";
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
      return MaterialPageRoute(builder: (context) =>   ProfileScreen(),);

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
      var homeListModel = settings.arguments as InvitationModel;
      return MaterialPageRoute(builder: (context) =>    DetailsScreen(homeListItemModel:homeListModel ),);



    case Routes.googleMapRoute:
      return MaterialPageRoute(builder: (context) =>    GoogleMapScreen(),);

    case Routes.reminderRoute:
       InvitationModel homeListItemModel=settings.arguments as  InvitationModel;
      return MaterialPageRoute(builder: (context) =>    ReminderScreen(homeListItemModel: homeListItemModel,),);

    case Routes.invitedRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    InvitedScreen(homeListItemModel: homeListItemModel,),);

    case Routes.messagesRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    MessagesScreen(homeListItemModel:homeListItemModel),);

    case Routes.addPersonRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    AddPerson(homeListItemModel:homeListItemModel),);

    // case Routes.addNewContactsRoute:
    //   return MaterialPageRoute(builder: (context) =>   const AddNewContacts(),);

    case Routes.sendNewContactsRoute:
      return MaterialPageRoute(builder: (context) =>   const SendNewContacts(),);

    case Routes.invitedRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;
      return MaterialPageRoute(builder: (context) =>    InvitedScreen(homeListItemModel: homeListItemModel,),);

    // case Routes.messagesRoute:
    //   return MaterialPageRoute(builder: (context) =>    MessagesScreen(),);

    // case Routes.addPersonRoute:
    //   return MaterialPageRoute(builder: (context) =>   const AddPerson(),);

    case Routes.addNewContactsRoute:
      return MaterialPageRoute(builder: (context) =>   const AddNewContacts(),);

    // case Routes.sendNewContactsRoute:
    //   return MaterialPageRoute(builder: (context) =>   const SendNewContacts(),);

    case Routes.scannedRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    ScannedScreen(homeListItemModel: homeListItemModel),);

    case Routes.confirmedRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    ConfirmedScreen(homeListItemModel: homeListItemModel),);

    case Routes.waitingRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    WaitingScreen(homeListItemModel: homeListItemModel),);

    case Routes.apologyRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    ApologyScreen(homeListItemModel: homeListItemModel),);

    case Routes.failedRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    FailedScreen(homeListItemModel: homeListItemModel),);

    case Routes.notSentRoute:
      InvitationModel homeListItemModel=settings.arguments as  InvitationModel;

      return MaterialPageRoute(builder: (context) =>    NotSentScreen(homeListItemModel: homeListItemModel),);

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
