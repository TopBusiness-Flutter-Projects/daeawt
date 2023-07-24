import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/features/home/presentation/screens/home_tab.dart';
import 'package:daeawt/features/home/presentation/screens/notification_screen.dart';
import 'package:daeawt/features/home/presentation/screens/profile_screen.dart';
import 'package:daeawt/features/home/presentation/screens/scan_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/home_app_bar.dart';

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
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: 170,
              right: 170,
              child: FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.primary,
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.addInvitationRoute);
                  }),
            ),
          ],
        ),
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
                  const Text(
                    AppStrings.home,
                    style: TextStyle(fontSize: 12),
                  ).tr()
                ],
              ),
            ),
            Tab(
              icon: Column(
                children: [
                  const Icon(Icons.notification_important),
                  const Text(
                    AppStrings.notifications,
                    style: TextStyle(fontSize: 12),
                  ).tr()
                ],
              ),
            ),
            Tab(
              icon: Column(
                children: [
                  const Icon(Icons.scanner),
                  const Text(
                    AppStrings.scan,
                    style: TextStyle(fontSize: 12),
                  ).tr(),
                ],
              ),
            ),
            Tab(
              icon: Column(
                children: [
                  const Icon(Icons.person_2_outlined),
                  const Text(
                    AppStrings.profile,
                    style: TextStyle(fontSize: 12),
                  ).tr(),
                ],
              ),
            ),
          ],
        ));
  }
}
