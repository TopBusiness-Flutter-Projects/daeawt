import 'package:daeawt/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/network_image.dart';

class HomeListItem extends StatelessWidget {
  final InvitationModel homeListItemModel;

  const HomeListItem({Key? key, required this.homeListItemModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.detailsRoute,
                arguments: homeListItemModel);
          },
          child: Card(

            child: Row(
              children: [
                SizedBox(width: 5,),
                homeListItemModel.image.isNotEmpty
                    ? ManageNetworkImage(
                        imageUrl: homeListItemModel.image,

                        width:120,
                        height:120,
                      )
                    : Image.asset(
                        ImageAssests.homeItem), //ImageAssests.homeItem,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          homeListItemModel.date, //sat, 01 jun 2023
                          style: const TextStyle(

                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(homeListItemModel.title, //عيد ميلاد
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                            ),
                            Flexible(
                              child: Text(
                                  softWrap: true,
                                  homeListItemModel.address,
                                  //شبين الكوم , المنوفية

                                  style: const TextStyle(

                                      fontSize: 14, fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right:languageCode=="ar"? MediaQuery.of(context).size.width * 0.4:
          MediaQuery.of(context).size.width * 0.3 ,
          left:languageCode=="ar"? MediaQuery.of(context).size.width * 0.3:
          MediaQuery.of(context).size.width * 0.4,
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: homeListItemModel.status == "0"||homeListItemModel.status==0
                      ? AppColors.grey1
                      : AppColors.lightGreen,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Text(
                homeListItemModel.status == "0"||homeListItemModel.status==0 ? "not_confirmed".tr() : "confirmed".tr(), //مؤكد
                style: TextStyle(
                    color:  homeListItemModel.status == "0"||homeListItemModel.status==0
                        ? AppColors.black1
                        : AppColors.green1),
              )),
        )
      ],
    );
  }
}
