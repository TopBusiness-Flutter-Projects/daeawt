import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/features/home/cubit/home_cubit.dart';
import 'package:daeawt/features/home/presentation/screens/home_tab.dart';
import 'package:daeawt/features/notifications/presentation/screens/notification_screen.dart';
import 'package:daeawt/features/profile/presentation/screens/profile_screen.dart';
import 'package:daeawt/features/scan/presenation/screens/scan_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../add_invitation/presentation/cubit/add_invitation_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  static List<Widget> pages = [
    HomeTab(),
    const NotificationScreen(),
    const ScanScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: pages.length, vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: pages,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: AppColors.primary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (cubit.userModel!.data!.user!.balance!>0){
                    Navigator.pushNamed(context, Routes.addInvitationRoute);}
                  else{
                    toastMessage("no_balance".tr(), context);
                  }
                }),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: TabBar(
              //dividerColor: AppColors.orange1,

              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.black,
              indicatorWeight: 1,

              controller: controller,
              tabs: [
                Tab(
                  icon: Column(
                    children: [
                      const Icon(
                        Icons.home,
                      ),
                      Text(
                        AppStrings.home,
                        style: TextStyle(fontSize: 8.sp),
                      ).tr()
                    ],
                  ),
                ),
                Tab(
                  icon: Column(
                    children: [
                      const Icon(Icons.notification_important),
                      Text(
                        AppStrings.notifications,
                        style: TextStyle(fontSize: 8.sp),
                      ).tr()
                    ],
                  ),
                ),
                Tab(
                  icon: Column(
                    children: [
                      const Icon(Icons.scanner),
                      Text(
                        AppStrings.scan,
                        style: TextStyle(fontSize: 8.sp),
                      ).tr(),
                    ],
                  ),
                ),
                Tab(
                  icon: Column(
                    children: [
                      const Icon(Icons.person_2_outlined),
                      Text(
                        AppStrings.profile,
                        style: TextStyle(fontSize: 8.sp),
                      ).tr(),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
