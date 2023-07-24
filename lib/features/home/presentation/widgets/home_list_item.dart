import 'package:daeawt/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/network_image.dart';

class HomeListItem extends StatelessWidget {
  final InvitationModel homeListItemModel ;
  const HomeListItem({Key? key,required this.homeListItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.detailsRoute,arguments: homeListItemModel);
          },
          child: Card(
            child: Row(
              children: [
                homeListItemModel.image.isNotEmpty?
                ManageNetworkImage(
                  imageUrl: homeListItemModel.image,
                  borderRadius: 90,
                  width: 110,
                  height: 110,
                ):Image.asset(ImageAssests.homeItem),//ImageAssests.homeItem,
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${homeListItemModel.date}",//sat, 01 jun 2023
                        style:
                            const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text("${homeListItemModel.title}",//عيد ميلاد
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Row(
                        children: [
                          const Icon(Icons.location_on,color: AppColors.primary,),
                          Text("${homeListItemModel.address}",//شبين الكوم , المنوفية
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),

                      SizedBox(
                        height: 45,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: MediaQuery.of(context).size.width*0.57,
          left: MediaQuery.of(context).size.width*0.2,
          child: Container(
            alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration:  BoxDecoration(
                  color:homeListItemModel.status=="0"?AppColors.grey1: AppColors.lightGreen,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child:  Text("${homeListItemModel.status=="0"?"not_confirmed".tr():"confirmed".tr()}",//مؤكد
                style:  TextStyle(color:homeListItemModel.status=="0"?AppColors.black1: AppColors.green1),)),
        )
      ],
    );
  }
}
