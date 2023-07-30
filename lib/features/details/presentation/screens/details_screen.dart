import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/my_svg_widget.dart';
import 'package:daeawt/core/widgets/show_loading_indicator.dart';
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../cubit/detials_cubit.dart';

class DetailsScreen extends StatefulWidget {
  final InvitationModel homeListItemModel;

  const DetailsScreen({Key? key, required this.homeListItemModel})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var languageCode = easy.EasyLocalization.of(context)!.locale.languageCode;
    return BlocConsumer<DetailsCubit, DetialsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        DetailsCubit cubit = context.read<DetailsCubit>();
        return Scaffold(
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ClipPath(
                clipper: SmallBottomCurveClipper(),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    AppColors.orange2,
                    AppColors.primary,
                  ])),
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                  height: 160,
                  width: double.infinity,
                  child: Row(
                    textDirection: TextDirection.ltr,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //arrow back
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Transform.rotate(
                          angle: languageCode == "ar" ? (3.14) : 0,
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      const Text(
                        AppStrings.occasionDetails,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ).tr(),
                      const Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColors.primary,
                              builder: (context) {
                                return Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      )),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      //settings
                                      Row(
                                        children: [
                                          const Text(
                                            AppStrings.settings,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Colors.white),
                                          ).tr(),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 25,
                                              )),
                                        ],
                                      ),
                                      //edit
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<AddInvitationCubit>()
                                              .setData(
                                                  widget.homeListItemModel);
                                          Navigator.pushNamed(context,
                                              Routes.addInvitationRoute);
                                        },
                                        child: Row(
                                          children: [
                                            const MySvgWidget(
                                                path: ImageAssests.editIcon,
                                                size: 25),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text(
                                              AppStrings.occasionModification,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ).tr()
                                          ],
                                        ),
                                      ),
                                      //delete
                                      InkWell(
                                        onTap: () {
                                          _showDialog(context);
                                        },
                                        child: Row(
                                          children: [
                                            const MySvgWidget(
                                                path: ImageAssests.deleteIcon,
                                                size: 25),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text(
                                              AppStrings.deleteTheOccasion,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ).tr()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const MySvgWidget(
                            path: ImageAssests.menuIcon,
                            size: 20,
                          )),
                    ],
                  ),
                ),
              ),
              Column(
                //  shrinkWrap: true,
                //   physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            backgroundColor: AppColors.black1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                AppStrings.send,
                                style: TextStyle(color: Colors.white),
                              ).tr(),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                          onPressed: () {
                            final RenderBox button =
                                context.findRenderObject() as RenderBox;
                            final RenderBox overlay = Overlay.of(context)
                                .context
                                .findRenderObject() as RenderBox;
                            final buttonOffset = button
                                .localToGlobal(Offset.zero, ancestor: overlay);

                            final menuItems = [
                              PopupMenuItem(
                                // onTap: () {
                                //   Navigator.pushNamed(context, Routes.reminderRoute);
                                // },
                                value: 'item1',
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, Routes.reminderRoute,
                                        arguments: widget.homeListItemModel);
                                  },
                                  child: const Text(
                                    AppStrings.sendReminder,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ).tr(),
                                ),
                              ),
                            ];

                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                buttonOffset.dx,
                                buttonOffset.dy +
                                    MediaQuery.of(context).size.height * 0.28,
                                buttonOffset.dx,
                                buttonOffset.dy +
                                    (menuItems.length *
                                        kMinInteractiveDimension),
                              ),
                              items: menuItems,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.56,
                      child: BlocBuilder<DetailsCubit, DetialsState>(
                        builder: (context, state) {
                          if (state is DetialsLoading) {
                            return const ShowLoadingIndicator();
                          } else {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.detailsIconsList.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 180,
                                      childAspectRatio: 3.5 / 2,
                                      //horizontal spaces
                                      crossAxisSpacing: 15,
                                      // vertical spaces
                                      mainAxisSpacing: 7),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (index == 1) {
                                      Navigator.pushNamed(
                                          context, Routes.invitedRoute,
                                          arguments: widget.homeListItemModel);
                                    } else if (index == 0) {
                                      Navigator.pushNamed(
                                          context, Routes.messagesRoute,
                                          arguments: widget.homeListItemModel);
                                    } else if (index == 2) {
                                      Navigator.pushNamed(
                                          context, Routes.scannedRoute,
                                          arguments: widget.homeListItemModel);
                                    } else if (index == 3) {
                                      Navigator.pushNamed(
                                          context, Routes.confirmedRoute,
                                          arguments: widget.homeListItemModel);
                                    } else if (index == 5) {
                                      Navigator.pushNamed(
                                          context, Routes.waitingRoute,
                                          arguments: widget.homeListItemModel);
                                    } else if (index == 4) {
                                      Navigator.pushNamed(
                                          context, Routes.apologyRoute,
                                          arguments: widget.homeListItemModel);
                                    } else if (index == 7) {
                                      Navigator.pushNamed(
                                          context, Routes.failedRoute,
                                          arguments: widget.homeListItemModel);
                                    } else if (index == 6) {
                                      Navigator.pushNamed(
                                          context, Routes.notSentRoute,
                                          arguments: widget.homeListItemModel);
                                    }
                                  },
                                  child: Material(
                                    elevation: 10,
                                    shadowColor: Colors.black.withOpacity(0.7),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MySvgWidget(
                                            path: cubit.detailsIconsList[index],
                                            size: 40),
                                        //  const SizedBox(height: 10,),
                                        Text(
                                          cubit.detailsdata[index],
                                          style: const TextStyle(
                                              color: AppColors.black1,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          cubit.detailsLabels[index],
                                          style: const TextStyle(
                                              color: AppColors.grey5,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ).tr(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )),

                  //اضافة مدعوين
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.addPersonRoute,
                          arguments: widget.homeListItemModel);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black1,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.85, 60),
                    ),
                    child: Text(
                      AppStrings.addGuests.tr(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //تفاصيل المناسبة
                  Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        cubit.visibleBottomDetailsWidget();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            AppStrings.occasionDetails,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ).tr(),
                          !cubit.isBottomDetailsWidgetVisible
                              ? const Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: AppColors.black1,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.arrow_drop_up_sharp,
                                  color: AppColors.black1,
                                  size: 30,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: cubit.isBottomDetailsWidgetVisible,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: widget.homeListItemModel.image.isNotEmpty
                                    ? ManageNetworkImage(
                                        imageUrl:
                                            widget.homeListItemModel.image,
                                      )
                                    : Image.asset(ImageAssests.homeItem),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.homeListItemModel.date,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                        color:
                                            widget.homeListItemModel.status ==
                                                    "0"
                                                ? AppColors.grey1
                                                : AppColors.lightGreen,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      widget.homeListItemModel.status == "0"
                                          ? "not_confirmed".tr()
                                          : "confirmed".tr(), //مؤكد
                                      style: TextStyle(
                                          color:
                                              widget.homeListItemModel.status ==
                                                      "0"
                                                  ? AppColors.black1
                                                  : AppColors.green1),
                                    )),
                              ],
                            ),
                            Text(widget.homeListItemModel.title,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700)),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primary,
                                ),
                                Text(widget.homeListItemModel.address,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 2),
          title: const Text(
            AppStrings.areYouSureDeleteOccasion,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ).tr(),
          content: Text(widget.homeListItemModel.title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.green3),
              child: TextButton(
                child: const Text(
                  AppStrings.confirm,
                  style: TextStyle(color: Colors.white),
                ).tr(),
                onPressed: () {
                  context.read<DetailsCubit>().delete(context);
                  // Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.red2),
              child: TextButton(
                child: const Text(
                  AppStrings.cancel,
                  style: TextStyle(color: Colors.white),
                ).tr(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<DetailsCubit>().setdata(widget.homeListItemModel);
  }
}
