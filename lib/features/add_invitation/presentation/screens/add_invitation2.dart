import 'package:daeawt/core/utils/toast_message_method.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_back_arrow.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/divider_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../../home/presentation/widgets/number_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import '../cubit/add_invitation_cubit.dart';
import 'package:daeawt/core/utils/assets_manager.dart';

class AddInvitationStepTwoScreen extends StatelessWidget {
  const AddInvitationStepTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;
    return BlocConsumer<AddInvitationCubit, AddInvitationState>(
      listener: (context, state) {},
      builder: (context, state) {
        AddInvitationCubit cubit = context.read<AddInvitationCubit>();
        return WillPopScope(
          onWillPop: () async{
            cubit.onSearchTextChanged('');
            return true;
          },
          child: Scaffold(
            body: Column(

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
                        padding:  const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        height: .2*MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: Center(
                          child:  Text(
                            cubit.homeListItemModel==null?
                            AppStrings.createNewInvitation:"update_invitation".tr(),
                            style:  const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.white),
                          ).tr(),
                        ),
                        //color: Colors.orange,
                      ),
                      const CustomBackArrow(),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        //first row of numbers in circles
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const NumberWidget(
                              backgroundColor: AppColors.black1,
                              text: "1",
                              textColor: Colors.white,
                            ),
                            const DividerCustomWidget(),
                            const NumberWidget(
                              backgroundColor: AppColors.black1,
                              text: "2",
                              textColor: Colors.white,
                            ),
                            const DividerCustomWidget(),
                            NumberWidget(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              text: "3",
                              textColor: AppColors.grey4,
                            ),
                            const DividerCustomWidget(),
                            NumberWidget(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              text: "4",
                              textColor: AppColors.grey4,
                            ),
                            const DividerCustomWidget(),
                            NumberWidget(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              text: "5",
                              textColor: AppColors.grey4,
                            ),
                          ],
                        ),
                         const SizedBox(
                          height: 4,
                        ),
                        //المضافين
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
                              Stack(
                                alignment:languageCode=="ar"? Alignment.centerRight:Alignment.centerLeft,
                                children: [
                                  const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.primary,
                                  ),
                                   Text(
                                    AppStrings.selectContacts,
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w700),
                                  ).tr(),
                                   Positioned(
                                    bottom: 3,
                                    // alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: 10,
                                      child: const Divider(
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
                        //
                        const SizedBox(
                          height: 8,
                        ),
                        //من فضلك حدد جهات الاتصال المطلوبة
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 8),
                              child:  const Text(
                                AppStrings.pleaseSelectContacts,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black1),
                              ).tr(),
                            ),
                          ],
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
                        //contacts
                        Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  // BoxShadow(color: Colors.grey, blurRadius: 10),
                                  // BoxShadow(color: Colors.white, blurRadius: 10),
                                  BoxShadow(color: Colors.black38, blurRadius: 5 ),
                                ]),
                            child: FutureBuilder<List<Contact>>(
                              future: cubit.getAllContacts(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData&&snapshot.data!.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, i) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           const Text(
                                            "المكرم",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Expanded(
                                          //  width: .5*MediaQuery.of(context).size.width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                    child: Text(
                                                  cubit.contactModelList[i].name!,
                                                  textAlign: TextAlign.center,
                                                  style:  const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w700),
                                                )),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: cubit.contactModelList[i]
                                                      .phones?.length,
                                                  itemBuilder: (context, index) {
                                                    return Text(
                                                      cubit.contactModelList[i]
                                                          .phones![index].value!.toString().replaceAll(" ", ""),
                                                      textAlign: TextAlign.center,

                                                      style:  TextStyle(
                                                          color: AppColors.grey5,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w700),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.edit)),
                                          TextButton(
                                              onPressed: () {
                                                if(cubit.contactModelList[i].isSelected==false
                                                    &&cubit.userModel!.data!.user!.balance!>0){
                                                cubit.contactModelList[i].isSelected =
                                                    cubit.changesSelectButton(cubit
                                                        .contactModelList[i]
                                                        .isSelected!);
                                                if (cubit
                                                    .contactModelList[i].isSelected!) {
                                                  if (cubit.contactModelList[i].phones!
                                                      .isNotEmpty) {
                                                    cubit.model.selectedContactModelList
                                                        .add(cubit.contactModelList[i]);
                                                    cubit.userModel!.data!.user!.balance=cubit.userModel!.data!.user!.balance!-1;
                                                  }
                                                }
                                             }
                                                else{
                                                  if(cubit.contactModelList[i].isSelected==true){
                                                    cubit.contactModelList[i].isSelected =
                                                        cubit.changesSelectButton(cubit
                                                            .contactModelList[i]
                                                            .isSelected!);

                                                    cubit.model.selectedContactModelList
                                                        .remove(
                                                        cubit.contactModelList[i]);
                                                    cubit.userModel!.data!.user!.balance=cubit.userModel!.data!.user!.balance!+1;


                                                  }
                                                  else {
                                                    toastMessage(
                                                        "no_balance".tr(),
                                                        context);
                                                  }
                                                }
                                              },
                                              child: !cubit
                                                      .contactModelList[i].isSelected!
                                                  ?  Text(
                                                      AppStrings.select,
                                                      style: TextStyle(
                                                          color: AppColors.primary,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700),
                                                    ).tr()
                                                  :  Text(
                                                      AppStrings.remove,
                                                      style: TextStyle(
                                                          color: AppColors.red1,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700),
                                                    ).tr()),
                                        ],
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return InkWell(
                                    onTap: () {
                                      cubit.getAllContacts();
                                    },
                                    child: Column(
                                      children: [
                                        const Icon(Icons.file_download),
                                        // Image.asset(ImageAssests.loadIcon,width: 20,
                                        //   height: 20,),
                                        const Text("error_getting_contacts").tr(),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        //last 2 buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  backgroundColor: AppColors.primary,
                                  onPressed: () {
                                   if(cubit.model.selectedContactModelList.length>0){
                                     cubit.model.step=3;

                                     Navigator.pushNamed(
                                         context, Routes.addInvitationStep3Route);
                                   }
                                   else{
                                     toastMessage("select_contact".tr(), context);
                                   }
                                  },
                                  text: AppStrings.tracking,
                                ),
                              ),
                               SizedBox(
                                width: 3,
                              ),
                              Visibility(
                                visible: cubit.homeListItemModel==null?true:false,

                                child:  Expanded(
                                child:  CustomButton(
                                    onPressed: () {
                                      if(cubit.model.selectedContactModelList.length>0){
                                        cubit.model.as_draft=1;

                                        cubit.addinviatation(context);

                                      }
                                      else{
                                        toastMessage("select_contact".tr(), context);
                                      }                          },
                                    text: AppStrings.saveAsDraft.tr(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
