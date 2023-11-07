import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/utils.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/constants/values/size_config.dart';
import 'package:gandiv/ui/views/dashboard_view/drawer_settings.dart';
import 'package:get/get.dart';
import '../../../route_management/routes.dart';
import '../../controllers/dashboard_page_cotroller.dart';
import '../../../constants/values/app_images.dart';
import '../bottombar_views/bookmark_page.dart';
import '../bottombar_views/editorial_news_page.dart';
import '../bottombar_views/home_page.dart';
import '../bottombar_views/breaking_news_page.dart';
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
  late PageController _pageController;
  //New
  final List<Widget> _bottomBarWidgets = <Widget>[
    const HomePage(),
    const BookmarkPage(),
    const EditorialNewsPage(),
    const BreakingNewsPage(),
  ];

  void myCallbackFunction() {
    controller.setTabbarIndex(0);
    HomePageState homeView = HomePageState();
    homeView.refreshPage();
    controller.setTabbarIndex(0);
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: buildAppBar(),
          ),
          drawer: Theme(
            data: controller.isDarkTheme.value == true
                ? Theme.of(context).copyWith(canvasColor: AppColors.dartTheme)
                : Theme.of(context).copyWith(canvasColor: AppColors.white),
            child: Drawer(
              // child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  DrawerSettings(
                      context: context, callback: myCallbackFunction),
                  DrawerEPaper(context: context),
                  DrawerSupport(context: context),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'app_version'.tr + controller.version.value,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
                // ),
              ),
            ),
          ),
          body: Center(
            child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {},
                children: _bottomBarWidgets),
            // child: Obx(() => _bottomBarWidgets
            //     .elementAt(controller.bottomTabbarIndex.value)),
          ),
          bottomNavigationBar:
              SizedBox(height: 60, child: buildBottomNavigationMenu()),
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
              width: 25,
              height: 35,
              color: controller.isDarkTheme.value == true
                  ? AppColors.white
                  : AppColors.black,
            ),
            onPressed: () {
              Get.toNamed(Routes.searchPage);
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 5),
          //   child: Stack(
          //     children: <Widget>[
          //       IconButton(
          //         icon: Image.asset(
          //           AppImages.notification,
          //           fit: BoxFit.contain,
          //           width: 35,
          //           height: 35,
          //           color: controller.isDarkTheme.value == true
          //               ? AppColors.white
          //               : AppColors.black,
          //         ),
          //         onPressed: () {
          //           Get.toNamed(Routes.notificationPage);
          //         },
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  buildBottomNavigationMenu() {
    return Obx(() => Padding(
          padding: EdgeInsets.only(top: 1),
          child: BottomNavigationBar(
            selectedFontSize: SizeConfig.bottomBarItemSelectedFontSize,
            unselectedFontSize: SizeConfig.bottomBarItemUnselectedFontSize,
            // selectedIconTheme:
            //     const IconThemeData(color: Colors.amberAccent, size: 40),
            selectedItemColor:
                Get.isDarkMode ? AppColors.white : AppColors.white,
            selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? AppColors.white : AppColors.white),
            unselectedIconTheme: IconThemeData(
              color: Get.isDarkMode ? AppColors.white : AppColors.white,
            ),
            unselectedItemColor:
                Get.isDarkMode ? AppColors.white : AppColors.white,
            currentIndex: controller.bottomTabbarIndex.value,
            onTap: _onItemTapped,
            backgroundColor: AppColors.dartTheme,
            // fixedColor: Colors.white,
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
                      : AppColors.white,
                ),
                tooltip: 'home'.tr,
                icon: Image.asset(
                  AppImages.home,
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                  color: controller.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.white,
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
                        : AppColors.white),
                icon: Image.asset(AppImages.bookmark,
                    fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                    color: controller.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.white),
                label: 'bookmark'.tr,
              ),
              BottomNavigationBarItem(
                tooltip: 'editorial_news'.tr,
                activeIcon: Image.asset(AppImages.editorialNews,
                    fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                    color: controller.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.white),
                icon: Image.asset(AppImages.editorialNews,
                    fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                    color: controller.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.white),
                label: 'editorial_news'.tr,
              ),
              BottomNavigationBarItem(
                tooltip: 'breaking_news'.tr,
                activeIcon: Image.asset(AppImages.breakingNewsIcon,
                    fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                    color: controller.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.white),
                icon: Image.asset(AppImages.breakingNewsIcon,
                    fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                    color: controller.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.white),
                label: 'breaking_news'.tr,
              ),
              // BottomNavigationBarItem(
              //   tooltip: 'profile'.tr,
              //   activeIcon: Image.asset(AppImages.profile,
              //       fit: BoxFit.contain,
              //       height: 25,
              //       width: 25,
              //       color: controller.isDarkTheme.value == true
              //           ? AppColors.white
              //           : AppColors.colorPrimary),
              //   icon: Image.asset(AppImages.profile,
              //       fit: BoxFit.contain,
              //       height: 25,
              //       width: 25,
              //       color: controller.isDarkTheme.value == true
              //           ? AppColors.white
              //           : AppColors.black),
              //   label: 'profile'.tr,
              // ),
            ],
          ),
        ));
  }

  //New
  void _onItemTapped(int index) {
    Utils(context).stopAudio();
    controller.setTabbarIndex(index);
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

    // setState(() {
    //   _selectedIndex = index;
    // });
  }
}
