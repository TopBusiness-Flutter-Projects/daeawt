import 'dart:async';

import 'package:daeawt/config/routes/app_routes.dart';
import 'package:daeawt/features/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

   Timer(const Duration(milliseconds: 1000),() {
     Navigator.pushReplacementNamed(context, Routes.loginRoute);
   },);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child:
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                    child: Image.asset(AssetsManager.splashLeftCorner,width:MediaQuery.of(context).size.width*0.75,)),
                Padding(
                  padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height*0.2),
                  child: Center(
                    child: SizedBox(
                      //height: 200,
                      width: MediaQuery.of(context).size.width*0.8,
                        child: Image.asset(AssetsManager.splashCenterLogo)),
                  ),
                ),
              const  Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                    child: Image.asset(AssetsManager.splashRightCorner,width:MediaQuery.of(context).size.width*0.95,)),
              ],
            ),
          )
        //Image.asset(AssetsManager.splashImage)
      ),
    );
  }
}
