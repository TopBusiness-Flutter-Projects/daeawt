import 'package:daeawt/features/confirmed/cubit/confirmed_cubit.dart';
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

class ConfirmedScreen extends StatefulWidget {
  const ConfirmedScreen({Key? key, required this.homeListItemModel}) : super(key: key);
  final InvitationModel homeListItemModel ;

  @override
  State<ConfirmedScreen> createState() => _ConfirmedScreenState();
}

class _ConfirmedScreenState extends State<ConfirmedScreen> {  @override
void initState() {
  super.initState();
  context.read<ConfirmedCubit>().setdata(widget.homeListItemModel);
}

  @override Widget build(BuildContext context) {
    ConfirmedCubit cubit=context.read<ConfirmedCubit>();

    var languageCode = easy.EasyLocalization.of(context)!.locale.languageCode;
    return BlocBuilder<ConfirmedCubit, ConfirmedState>(
  builder: (context, state) {
    return WillPopScope(
      onWillPop: () async{
        cubit.onSearchTextChanged('');
        return true;
      },
      child: Scaffold (
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
                    SizedBox(width: MediaQuery.of(context).size.width*0.25,),
                     Text(
                      AppStrings.confirmation,
                      style: TextStyle(
                          fontSize: 13,
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
                    hintText: AppStrings.search,
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
                        radius: 12,
                        backgroundColor: AppColors.primary,
                        child: Center(
                            child: IconButton(
                              onPressed: () {
                                //TODO-->
                                //cubit.removeSelectedContact(index);
                              },
                              icon:  Icon(
                                Icons.close,
                                size:.015*MediaQuery.of(context).size.height,
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
                            easy.DateFormat('dd HH:mm MMM').format(  easy.DateFormat('dd-MM-yyyy').parse(cubit.invitees.elementAt(index).createdAt)),
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
      ),
    );
  },
);
  }
}
