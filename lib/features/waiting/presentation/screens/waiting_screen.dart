import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../cubit/waiting_cubit.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key, required this.homeListItemModel}) : super(key: key);
  final InvitationModel homeListItemModel ;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WaitingCubit>().setdata(widget.homeListItemModel);
  }
  @override
  Widget build(BuildContext context) {
    WaitingCubit cubit=context.read<WaitingCubit>();

    var languageCode = easy.EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold (
      body: BlocBuilder<WaitingCubit, WaitingState>(
  builder: (context, state) {
    return Column(
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
                    AppStrings.wait.tr(),
                    style: const TextStyle(
                        fontSize: 14,
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
                height: 60,
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
                padding:  EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [

                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: Center(
                          child: IconButton(
                            onPressed: () {
                              //TODO-->
                              //cubit.removeSelectedContact(index);
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.zero,
                          )),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        Row(children: [
                          const Text("المكرم :",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ),
                          ),
                          Text(
                            cubit.invitees.elementAt(index).name ,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),),
                        ],),
                        Text(
                          easy.DateFormat('dd HH:mm MMM').format(cubit.invitees.elementAt(index).createdAt),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.grey2
                          ),),

                      ],),
                    const Spacer(),
                     const MySvgWidget(path: ImageAssests.shareIcon, size: 20),

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
      );
  },
),
    );
  }
}
