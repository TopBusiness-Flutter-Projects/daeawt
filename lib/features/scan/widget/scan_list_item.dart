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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Stack(
        children: [
          Card(
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                homeListItemModel.image.isNotEmpty
                    ? ManageNetworkImage(
                  imageUrl: homeListItemModel.image,
                  borderRadius: 90,
                  width: 90,
                  height: 90,
                )
                    : Image.asset(
                    ImageAssests.homeItem),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy EEE MMM dd  ').format(DateTime.parse(homeListItemModel.date))
                     ,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(homeListItemModel.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text("الرقم السرى",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text(homeListItemModel.password,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey4)),

                      SizedBox(
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
              right: MediaQuery.of(context).size.width * 0.47,
              left: MediaQuery.of(context).size.width * 0.13,
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
                child: const Text("المسح الضوئى",
                    //"${homeListItemModel.status=="0"?"not_confirmed".tr():"confirmed".tr()}",//مؤكد
                    style: TextStyle(
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
