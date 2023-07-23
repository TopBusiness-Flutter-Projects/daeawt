import 'package:daeawt/core/widgets/my_svg_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class InvitedScreen extends StatelessWidget {
  const InvitedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: SmallBottomCurveClipper(),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColors.orange2,
                        AppColors.primary,
                      ])),
                  padding: const EdgeInsets.symmetric(
                      vertical: 60, horizontal: 40),
                  height: 160,
                  width: double.infinity,
                  child: Center(
                    child: const Text(
                      AppStrings.invited,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white),
                    ).tr(),
                  ),
                  //color: Colors.orange,
                ),
                Positioned(
                    left: 20,
                    top: 60,
                    child: Directionality.of(context) == TextDirection.LTR
                        ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 35,
                      ),
                    )
                        : IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 35,
                        )))
              ],
            ),
          ),
          //ابحث
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 60,
                child: CustomTextFormField(
                  onChanged: (p0) {

                  },
                  hintText: AppStrings.search,
                  prefixIcon: const Icon(Icons.search),
                )),
          ),
          Expanded(child: ListView.separated(
              itemBuilder:(context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [

                      Positioned(
                          right: 0,
                          top: 15,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primary,
                            child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    //TODO-->
                                    //cubit.removeSelectedContact(index);
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.zero,
                                )),
                          )),
                   const SizedBox(width: 10,),
                      const Column(
                        children: [
                          Row(children: [
                            Text("المكرم :",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20
                            ),
                            ),
                            Text("محمد" ,style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20
                            ),),
                          ],),
                          Text("14 jun 09:06",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              color: AppColors.grey2
                            ),),

                      ],),
                      const Spacer(),
                      const MySvgWidget(path: AssetsManager.shareIcon, size: 20),

                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>Divider() ,
              itemCount: 4))
        ],
      ),
    );
  }
}
