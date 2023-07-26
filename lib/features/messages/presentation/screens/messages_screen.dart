import 'package:daeawt/features/messages/presentation/cubit/messages_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key, required this.homeListItemModel}) : super(key: key);
  final InvitationModel homeListItemModel ;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MessagesCubit>().setdata(widget.homeListItemModel);
  }
  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;
    return Scaffold(
      body: BlocConsumer<MessagesCubit, MessagesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          MessagesCubit cubit = context.read<MessagesCubit>();
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
                          AppStrings.theMessages,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white),
                        ).tr(),
                      ),
                      //color: Colors.orange,
                    ),
                    Positioned(
                        left: 20,
                        top: 60,
                        child: Transform.rotate(
                          angle:languageCode=="ar"?0:(3.14) ,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              )),)
                    )
                  ],
                ),
              ),

              Expanded(child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                           Row(
                            children: [
                              const Text("المكرم :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                ),
                              ),
                              Text(cubit.invitees.elementAt(index).name , style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20
                              ),),
                            ],),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text("محتوى الرسالة ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey2
                                  ),)),

                              IconButton(
                                icon: cubit.isVisible?
                                const Icon(Icons.arrow_drop_up):
                                const Icon(Icons.arrow_drop_down),
                                onPressed: () {
                                 cubit.changeVisibility();
                                },),

                            ],),
                          Visibility(
                            visible: cubit.isVisible,
                            child:

                            ListView.builder(
                            itemBuilder: (context, index1) {
                              return  Text(cubit.invitees.elementAt(index).messages.elementAt(index1).message);
                            },
                              itemCount: cubit.invitees.elementAt(index).messages.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          )


                        ],),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: cubit.invitees.length))
            ],
          );
        },
      ),
    );
  }
}
