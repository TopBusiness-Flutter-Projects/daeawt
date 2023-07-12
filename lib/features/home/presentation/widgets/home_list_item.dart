import 'package:daeawt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Row(
            children: [
              Image.asset(AssetsManager.homeItem,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "sat, 01 jun 2023",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Text("عيد ميلاد",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        Icon(Icons.location_on,color: AppColors.primary,),
                        Text("شبين الكوم , المنوفية",
                            style: TextStyle(
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
        Positioned(
          bottom: 4,
          right: MediaQuery.of(context).size.width*0.57,
          left: MediaQuery.of(context).size.width*0.2,
          child: Container(
            alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: const BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: const Text("مؤكد",style: TextStyle(color: AppColors.green1),)),
        )
      ],
    );
  }
}
