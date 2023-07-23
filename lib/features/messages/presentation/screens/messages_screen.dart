import 'package:daeawt/features/messages/presentation/cubit/messages_cubit.dart';
import 'package:daeawt/features/messages/presentation/cubit/messages_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        child: Directionality.of(context) == TextDirection.LTR
                            ? IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 35,
                          ),
                        )
                            : IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35,
                            )))
                  ],
                ),
              ),

              Expanded(child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text("المكرم :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                ),
                              ),
                              Text("محمد", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20
                              ),),
                            ],),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text("محتوى الرسالة محتوى الرسالة ",
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
                            child: Text("details , details, details, details"),
                            visible: cubit.isVisible,
                          )


                        ],),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 4))
            ],
          );
        },
      ),
    );
  }
}
