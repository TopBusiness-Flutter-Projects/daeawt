import 'package:daeawt/core/model/InvitationDataModel.dart';
import 'package:daeawt/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';

class ScanListItem extends StatelessWidget {
  const ScanListItem({Key? key, required this.homeListItemModel}) : super(key: key);
  final InvitationModel homeListItemModel;
  @override
  Widget build(BuildContext context) {
    String language = EasyLocalization.of(context)!.locale.languageCode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
      child: Stack(
        children: [
          Card(
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 2,),
                homeListItemModel.image.isNotEmpty
                    ? ManageNetworkImage(
                  imageUrl: homeListItemModel.image,

                  width: MediaQuery.of(context).size.width/4,
                  height: 120,
                )
                    : Image.asset(
                    ImageAssests.homeItem),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy EEE MMM dd  ').format(DateTime.parse(homeListItemModel.date))
                     ,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(homeListItemModel.title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      Text("secret_number".tr(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(homeListItemModel.password,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey4)),

                      const SizedBox(
                        height: 45,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 50.0),
                      //   child: Container(
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //       color: Colors.green,
                      //       borderRadius: BorderRadius.circular(10)
                      //     ),
                      //       child: Text("approved")),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 4,
              right:language=="ar"?
              MediaQuery.of(context).size.width * 0.47:
              MediaQuery.of(context).size.width * 0.2
              ,
              left:language=="ar"?
              MediaQuery.of(context).size.width * 0.13:
              MediaQuery.of(context).size.width * 0.42
              ,
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: const BoxDecoration(
                    color: AppColors.primary,
                    // homeListItemModel.status=="0"?AppColors.grey1: AppColors.lightGreen,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child:  Text("photo_scan".tr(),
                    //"${homeListItemModel.status=="0"?"not_confirmed".tr():"confirmed".tr()}",//مؤكد
                    style: const TextStyle(
                      color: Colors.white
                      //homeListItemModel.status=="0"?AppColors.black1: AppColors.green1)
                      ,
                    )),
              ))
        ],
      ),
    );
  }
}
