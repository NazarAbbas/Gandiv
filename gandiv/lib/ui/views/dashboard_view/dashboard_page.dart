import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/views/dashboard_view/drawer_settings.dart';
import 'package:get/get.dart';
import '../../../route_management/routes.dart';
import '../../controllers/dashboard_page_cotroller.dart';
import '../../../constants/values/app_images.dart';
import '../bottombar_views/bookmark_page.dart';
import '../bottombar_views/home_page.dart';
import '../bottombar_views/location_page.dart';
import '../bottombar_views/profile_page.dart';
import 'drawer_account.dart';
import 'drawer_e_paper.dart';
import 'drawer_support.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

// ignore: must_be_immutable
typedef MyCallback = void Function();

class DashboardPageState extends State<DashboardPage> {
  DashboardPageController controller = Get.find<DashboardPageController>();

  //New
  final List<Widget> _bottomBarWidgets = <Widget>[
    HomePage(),
    const BookmarkPage(),
    const LocationPage(),
    ProfilePage()
  ];

  void myCallbackFunction() {
    controller.setTabbarIndex(0);
    HomePageState homeView = HomePageState();
    homeView.refreshPage();
    //Get.toNamed(Routes.dashboardScreen);
    //controller.setTabbarIndex(0);
    //(context as Element).reassemble();
    // setState(() {});
    // You can perform any action based on the callback data here
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: buildAppBar(),
          ),
          drawer: Theme(
            data: controller.isDarkTheme.value == true
                ? Theme.of(context).copyWith(canvasColor: AppColors.dartTheme)
                : Theme.of(context).copyWith(canvasColor: AppColors.white),
            child: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DrawerSettings(
                        context: context, callback: myCallbackFunction),
                    DrawerEPaper(context: context),
                    DrawerSupport(context: context),
                    DrawerAccount(
                        context: context, callback: myCallbackFunction),
                  ],
                ),
              ),
            ),
          ),
          body: Center(
            child: Obx(() => _bottomBarWidgets
                .elementAt(controller.bottomTabbarIndex.value)),
          ),
          bottomNavigationBar: buildBottomNavigationMenu(),
        ),
      ),
    );
  }

  buildAppBar() {
    return Obx(
      () => AppBar(
        backgroundColor: controller.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Image.asset(
            AppImages.appLogo,
            fit: BoxFit.contain,
            color: controller.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.black,
          ),
        ),
        iconTheme: IconThemeData(
            color: controller.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.black),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              AppImages.search,
              fit: BoxFit.contain,
              width: 35,
              height: 35,
              color: controller.isDarkTheme.value == true
                  ? AppColors.white
                  : AppColors.black,
            ),
            onPressed: () {
              Get.toNamed(Routes.searchPage);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    AppImages.notification,
                    fit: BoxFit.contain,
                    width: 35,
                    height: 35,
                    color: controller.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.black,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.notificationPage);
                  },
                ),
                // Positioned(
                //   top: 35,
                //   bottom: 0,
                //   left: 20,
                //   right: 0,
                //   child: Text(
                //     '.',
                //     style: TextStyle(
                //       color: AppColors.colorPrimary,
                //       //code here
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildBottomNavigationMenu() {
    return Obx(() => BottomNavigationBar(
          selectedFontSize: 16,
          // selectedIconTheme:
          //     const IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor:
              Get.isDarkMode ? AppColors.white : AppColors.colorPrimary,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? AppColors.white : AppColors.black),
          unselectedIconTheme: IconThemeData(
            color: Get.isDarkMode ? AppColors.white : AppColors.black,
          ),
          unselectedItemColor:
              Get.isDarkMode ? AppColors.white : AppColors.dartTheme,
          currentIndex: controller.bottomTabbarIndex.value,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                AppImages.home,
                fit: BoxFit.contain,
                height: 25,
                width: 25,
                color: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.colorPrimary,
              ),
              tooltip: 'home'.tr,
              icon: Image.asset(
                AppImages.home,
                fit: BoxFit.contain,
                height: 25,
                width: 25,
                color: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              tooltip: 'bookmark'.tr,
              activeIcon: Image.asset(AppImages.bookmark,
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                  color: controller.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.colorPrimary),
              icon: Image.asset(AppImages.bookmark,
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                  color: controller.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black),
              label: 'bookmark'.tr,
            ),
            BottomNavigationBarItem(
              tooltip: 'location'.tr,
              activeIcon: Image.asset(AppImages.location,
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                  color: controller.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.colorPrimary),
              icon: Image.asset(AppImages.location,
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                  color: controller.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black),
              label: 'location'.tr,
            ),
            BottomNavigationBarItem(
              tooltip: 'profile'.tr,
              activeIcon: Image.asset(AppImages.profile,
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                  color: controller.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.colorPrimary),
              icon: Image.asset(AppImages.profile,
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                  color: controller.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black),
              label: 'profile'.tr,
            ),
          ],
        ));
  }

  //New
  void _onItemTapped(int index) {
    controller.setTabbarIndex(index);
    // setState(() {
    //   _selectedIndex = index;
    // });
  }
}
