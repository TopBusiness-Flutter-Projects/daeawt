import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';


class ProfileScreen extends StatelessWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
             height:MediaQuery.of(context).size.height,
              color: AppColors.primary,

            ),
          ),

          Positioned(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight:Radius.circular(40) ,topLeft:Radius.circular(40) ),
              ),

            ),
          ),
           Positioned(
              top: 100,
              child:  Row(

                children: [
                   SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  const Text(AppStrings.myAccount,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),).tr(),
                  SizedBox(width: MediaQuery.of(context).size.width*0.55),
                  const Icon(Icons.delete_outline,color: Colors.white,),
                  const SizedBox(width: 10,),
                   IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.editProfileRoute);
                    },
                  icon: const Icon(Icons.edit_calendar_outlined,color: Colors.white,)),
                  const SizedBox(width: 50,),

                ],
              )),

          //first 2 circles
           Positioned(
            top: MediaQuery.of(context).size.height*0.25,
            right: MediaQuery.of(context).size.width*0.1,
              child: const CircleAvatar(radius: 4,backgroundColor: AppColors.primary,),
          ),
           Positioned(
             top: MediaQuery.of(context).size.height*0.25,
            left:  MediaQuery.of(context).size.width*0.1,
            child: const CircleAvatar(radius: 4,backgroundColor: AppColors.primary,),
          ),

         // second row of circles
          Positioned(
            top:  MediaQuery.of(context).size.height*0.3,
            right:   MediaQuery.of(context).size.width*0.05,
            child: CircleAvatar(radius: 3,backgroundColor: AppColors.primary,),
          ),
          Positioned(
            top:   MediaQuery.of(context).size.height*0.3,
            left: MediaQuery.of(context).size.width*0.05,
            child: CircleAvatar(radius: 3,backgroundColor: AppColors.primary,),
          ),

         // second row of circles
          Positioned(
            top:  MediaQuery.of(context).size.height*0.3,
            left:MediaQuery.of(context).size.width*0.21,
            child: CircleAvatar(radius: 3,backgroundColor: AppColors.primary,),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.3,
            right: MediaQuery.of(context).size.width*0.21,
            child: const CircleAvatar(radius: 3,backgroundColor: AppColors.primary,),
          ),

         //third row of circles
           Positioned(
            top: MediaQuery.of(context).size.height*0.35,
            right: MediaQuery.of(context).size.width*0.13,
            child: const CircleAvatar(radius: 4,backgroundColor: AppColors.primary,),
          ),
           Positioned(
            top: MediaQuery.of(context).size.height*0.35,
            left: MediaQuery.of(context).size.width*0.13,
            child: const CircleAvatar(radius: 4,backgroundColor: AppColors.primary,),
          ),

          //profile image
          Positioned(
            top:MediaQuery.of(context).size.height*0.22 ,
              child: Container(
                padding:    EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  border: Border.all(color:AppColors.grey3,width: 3)
                ),
                child: Image.asset(AssetsManager.profileImage),
              )
          ),

          //all fields
          Positioned(
           top: MediaQuery.of(context).size.height*0.37,
            right: 0,
            left: 0,
            bottom:0 ,
            child:  SingleChildScrollView(
              child: Column(

                children: [
                  const Text('محمد محمد',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18),),
                  const Text('01030504268',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18),),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    width:MediaQuery.of(context).size.width*0.85 ,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2,color: AppColors.grey3)
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetsManager.languageIcon),
                        const SizedBox(width: 15,),
                        const Text(AppStrings.language,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),).tr(),
                        SizedBox(width: MediaQuery.of(context).size.width*0.5,),
                        Directionality.of(context)==TextDirection.LTR?
                        Text("ع"): Text("En")

                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.contactUsRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      width:MediaQuery.of(context).size.width*0.85 ,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2,color: AppColors.grey3)
                      ),
                      child: Row(
                        children: [
                          Image.asset(AssetsManager.contactUsIcon),
                          const SizedBox(width: 15,),
                          const Text(AppStrings.contactUs,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),).tr(),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    width:MediaQuery.of(context).size.width*0.85 ,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2,color: AppColors.grey3)
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetsManager.shareAppIcon),
                        const SizedBox(width: 15,),
                        const Text(AppStrings.shareApp,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),).tr(),

                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    width:MediaQuery.of(context).size.width*0.85 ,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2,color: AppColors.grey3)
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetsManager.rateAppIcon),
                        const SizedBox(width: 15,),
                        const Text(AppStrings.rateApp,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),).tr(),

                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.loginRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      width:MediaQuery.of(context).size.width*0.85 ,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2,color: AppColors.grey3)
                      ),
                      child: Row(
                        children: [
                          Image.asset(AssetsManager.logOutIcon),
                          const SizedBox(width: 15,),
                          const Text(AppStrings.logout,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),).tr(),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //social media row
          Positioned(
            top: MediaQuery.of(context).size.height*0.89,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsManager.facebookIcon),
                  const SizedBox(width: 10,),
                  Image.asset(AssetsManager.instagramIcon),
                  const SizedBox(width: 10,),
                  Image.asset(AssetsManager.twitterIcon),
                  const SizedBox(width: 10,),
                  Image.asset(AssetsManager.linkedInIcon),
                ],
              )),


        ],
      ),
    );
  }
}
