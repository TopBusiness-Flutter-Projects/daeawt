import 'package:daeawt/features/failed/presentation/cubit/faild_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/shareinvitee.dart';
import '../../../../core/widgets/custom_back_arrow.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class FailedScreen extends StatefulWidget {
  const FailedScreen({Key? key, required this.homeListItemModel}) : super(key: key);
  final InvitationModel homeListItemModel ;

  @override
  State<FailedScreen> createState() => _FailedScreenState();
}

class _FailedScreenState extends State<FailedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FaildCubit>().setdata(widget.homeListItemModel);
  }
  @override
  Widget build(BuildContext context) {
    FaildCubit cubit=context.read<FaildCubit>();

    var languageCode = easy.EasyLocalization.of(context)!.locale.languageCode;
    return WillPopScope(
      onWillPop: () async{
        cubit.onSearchTextChanged('');
        return true;
      },
      child: Scaffold (
        body: BlocBuilder<FaildCubit, FaildState>(
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
                  padding:
                  EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  height: 20.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      AppStrings.failed,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.white),
                    ).tr(),
                  ),
                  //color: Colors.orange,
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                const CustomBackArrow(),
              ],
            ),
          ),
          //ابحث
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 6.h,
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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: AppColors.primary,
                            child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    //TODO-->
                                    //cubit.removeSelectedContact(index);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 1.5.h,
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
                                  Text(
                                    "المكرم :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    cubit.invitees.elementAt(index).name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                              Text(
                                easy.DateFormat('dd HH:mm MMM').format(
                                  DateTime.parse(cubit.invitees.elementAt(index).createdAt)),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    color: AppColors.grey2),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                shareInvitee(cubit.invitees.elementAt(index),
                                    widget.homeListItemModel, context);
                              },
                              child: MySvgWidget(
                                  path: ImageAssests.shareIcon, size: 5.w))                        ],
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
      ),
    );
  }
}
