import 'package:daeawt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';

class ScanListItem extends StatelessWidget {
  const ScanListItem({Key? key}) : super(key: key);

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
                Image.asset(ImageAssests.homeItem),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "sat, 01 jun 2023",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text("عيد ميلاد",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text("الرقم السرى",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text("1234567",
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
