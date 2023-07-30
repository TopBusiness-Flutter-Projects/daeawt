import 'package:daeawt/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/InvitationDataModel.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class ReminderScreen extends StatefulWidget {
  final InvitationModel homeListItemModel;

  const ReminderScreen({Key? key, required this.homeListItemModel})
      : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    String languageCode =
        easy.EasyLocalization.of(context)!.locale.languageCode;

    return BlocConsumer<ReminderCubit, ReminderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ReminderCubit cubit = context.read<ReminderCubit>();
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      const Text(
                        AppStrings.sendReminder,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ).tr(),
                    ],
                  ),
                ),
              ),
              //حدد جهات الاتصال
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary,
                        ),
                        const Text(
                          AppStrings.selectContacts1,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ).tr(),
                        const Positioned(
                          bottom: 3,
                          // alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 40,
                            child: Divider(
                              color: AppColors.cyan,
                              thickness: 2,
                              height: 2,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              //سيتم ارسال التذكير لكل جهات الاتصال المحددة
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8),
                    child: const Text(
                      AppStrings.reminderWillBeSent,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black1),
                    ).tr(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //search
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      cubit.onSearchTextChanged(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'username_valid'.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        prefixIcon: const Icon(Icons.search),
                        hintText: AppStrings.searchYourInvitations.tr(),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: AppColors.grey1,
                        filled: true),
                  ),
                ),
              ),
              //تحديد الكل
              InkWell(
                onTap: () {
                  cubit.changeall();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child:  Text(
                        "select_all".tr(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary),
                      ).tr(),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: cubit.invitees.length,
                //context.read<AddInvitationCubit>().selectedContactModelList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: InkWell(
                      onTap: () {
                        cubit.changevalue(index);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 20,
                            child: CheckboxListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: cubit.invitees.elementAt(index).isselected,
                              onChanged: (bool? value) {
                                cubit.changevalue(index);
                                // cubit.changeWithBarcodeCheckListTile(value);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20,
                              child: Center(
                                child: Text(
                                  cubit.invitees.elementAt(index).name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: AppColors.black1),
                                  // context.read<AddInvitationCubit>().selectedContactModelList[index].name!
                                ),
                              ),
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  );
                },
              )),
              //اضافة مدعوين
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    cubit.sendReminder(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black1,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.85, 60),
                  ),
                  child: Text(
                    AppStrings.send.tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ReminderCubit>().setdata(widget.homeListItemModel);
  }
}
