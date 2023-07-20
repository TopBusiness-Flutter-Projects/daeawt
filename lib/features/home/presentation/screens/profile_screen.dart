import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/my_svg_widget.dart';


class ProfileScreen extends StatelessWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    HomeCubit cubit = context.read<HomeCubit>();
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
                   SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                  const Text(AppStrings.myAccount,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),).tr(),
                  SizedBox(width: MediaQuery.of(context).size.width*0.5),
                  const  MySvgWidget(path: AssetsManager.deleteIcon, size: 22),
                  const SizedBox(width: 10,),
                   IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.editProfileRoute);
                    },
                  icon: const MySvgWidget(path: AssetsManager.editIcon, size: 22),),
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
                    child: InkWell(
                      onTap: () {
                        cubit.changeApplicationLanguage(context);
                       // EasyLocalization.of(context)?.setLocale(Locale('en', ''));

                      },
                      child: Row(
                        children: [
                          Image.asset(AssetsManager.languageIcon),
                          const SizedBox(width: 15,),
                          const Text(AppStrings.language,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),).tr(),
                          SizedBox(width: MediaQuery.of(context).size.width*0.4,),
                          Localizations.localeOf(context)==Locale("en")?
                          Text(cubit.arabicSymbol): Text(cubit.englishSymbol)

                        ],
                      ),
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
  },
);
  }
}
