import 'package:daeawt/features/scanned/presentation/cubit/scanned_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/shareinvitee.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class ScannedScreen extends StatefulWidget {
  const ScannedScreen({Key? key, required this.homeListItemModel}) : super(key: key);
  final InvitationModel homeListItemModel ;

  @override
  State<ScannedScreen> createState() => _ScannedScreenState();
}

class _ScannedScreenState extends State<ScannedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScannedCubit>().setdata(widget.homeListItemModel);
  }
  @override
  Widget build(BuildContext context) {
    var languageCode = easy.EasyLocalization.of(context)!.locale.languageCode;
    ScannedCubit cubit=context.read<ScannedCubit>();

    return BlocBuilder<ScannedCubit, ScannedState>(
  builder: (context, state) {
    return Scaffold (
      body: Column(
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
              EdgeInsets.symmetric(vertical: .05*MediaQuery.of(context).size.height, horizontal: .1*MediaQuery.of(context).size.width),
              height: .2*MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon:
                    Transform.rotate(
                      angle: languageCode == "ar"? (3.14):0,
                      child:   const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                   Text(
                    AppStrings.scanned,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ).tr(),

                ],
              ),
            ),
          ),
          //ابحث
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height:.06*MediaQuery.of(context).size.height,
                child: CustomTextFormField(
                  onChanged: (p0) {
                    cubit.onSearchTextChanged(p0);
                  },
                  hintText: AppStrings.search.tr(),
                  prefixIcon: const Icon(Icons.search),
                )),
          ),
          Expanded(child: ListView.separated(
            itemBuilder:(context, index) {
              return Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [

                    CircleAvatar(
                      radius: .03*MediaQuery.of(context).size.width,
                      backgroundColor: AppColors.primary,
                      child: Center(
                          child: IconButton(
                            onPressed: () {
                              //TODO-->
                              //cubit.removeSelectedContact(index);
                            },
                            icon:  Icon(
                              Icons.close,
                               size: .015*MediaQuery.of(context).size.height,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.zero,
                          )),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        Row(children: [
                           Text("المكرم :",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 11
                            ),
                          ),
                          Text(
                            cubit.invitees.elementAt(index).name ,
                            style:  TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11
                          ),),
                        ],),
                        Text(
                          easy.DateFormat('dd HH:mm MMM').format(   easy.DateFormat('dd-MM-yyyy').parse(cubit.invitees.elementAt(index).createdAt)),
                          style:  TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: AppColors.grey2
                          ),),

                      ],),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          shareInvitee(cubit.invitees.elementAt(index),
                              widget.homeListItemModel, context);
                        },
                        child: MySvgWidget(
                            path: ImageAssests.shareIcon, size: .05*MediaQuery.of(context).size.width))
                  ],
                ),
              );
            },
            // separatorBuilder: (context, index) =>Divider() ,
            itemCount:
            cubit.invitees.length
            , separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },))
        ],
      ),
    );
  },
);
  }
}
