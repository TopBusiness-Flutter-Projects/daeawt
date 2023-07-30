import 'package:daeawt/core/widgets/my_svg_widget.dart';
import 'package:daeawt/features/invited/presentation/cubit/invited_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class InvitedScreen extends StatefulWidget {
  final InvitationModel homeListItemModel;

  const InvitedScreen({Key? key, required this.homeListItemModel})
      : super(key: key);

  @override
  State<InvitedScreen> createState() => _InvitedScreenState();
}

class _InvitedScreenState extends State<InvitedScreen> {
  @override
  Widget build(BuildContext context) {
    String? languageCode =
        easy.EasyLocalization.of(context)?.locale.languageCode;
    InvitedCubit cubit = context.read<InvitedCubit>();
    return Scaffold(
      body: BlocBuilder<InvitedCubit, InvitedState>(
        builder: (context, state) {
          return Column(
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
                              fontSize: 14,
                              color: Colors.white),
                        ).tr(),
                      ),
                      //color: Colors.orange,
                    ),
                    Positioned(
                        left: 20,
                        top: 60,
                        child: Transform.rotate(
                          angle: languageCode == "ar" ? 0 : (3.14),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              )),
                        ))
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
                        cubit.onSearchTextChanged(p0);
                      },
                      hintText: AppStrings.search.tr(),
                      prefixIcon: const Icon(Icons.search),
                    )),
              ),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      height: 60,
                      child: Row(
                        children: [
                          CircleAvatar(
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "المكرم :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    cubit.invitees.elementAt(index).name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Text(
                                easy.DateFormat('dd HH:mm MMM').format(
                                    cubit.invitees.elementAt(index).createdAt),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.grey2),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const MySvgWidget(
                              path: ImageAssests.shareIcon, size: 20),
                        ],
                      ),
                    ),
                  );
                },
                // separatorBuilder: (context, index) =>Divider() ,
                itemCount: cubit.invitees.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ))
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<InvitedCubit>().setdata(widget.homeListItemModel);
  }
}
