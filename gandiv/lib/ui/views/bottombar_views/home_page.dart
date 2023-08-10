import 'package:flutter/material.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/home_page_contoller.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/get.dart';
import '../news_views/home_news_page.dart';
import '../news_views/international_news_page.dart';
import '../news_views/national_news_page.dart';
import '../news_views/state_news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

// ignore: must_be_immutable
class HomePageState extends State<HomePage> {
  //HomePageState({super.key});
  DashboardPageController dashboardScreenController =
      Get.find<DashboardPageController>();

  HomePageController controller = Get.find<HomePageController>();

  final List<Widget> _bottomBarWidgets = <Widget>[
    const HomeNewsPage(),
    const StateNewsPage(),
    const NationalNewsPage(),
    const InterNationalNewsPage()
  ];

  void refreshPage() async {
    HomeNewsPageListRow().controller.newsList.clear();
    final index = controller.tabController.index;
    if (index == 0) {
      final xxxx = HomeNewsPageListRow().refreshPage();
    } else {
      controller.onInit();
    }
    controller.onInit();

    // setState(() {});
    // final index = controller.tabController.index;
    // if (index == 0) {
    //   final xxxx = HomeNewsPageListRow().refreshPage();
    // }

    //xxxx.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildAppBar(),
      ),
      body: TabBarView(
          controller: controller.tabController, children: _bottomBarWidgets),
    );
  }

  Obx buildAppBar() {
    return Obx(
      () => AppBar(
        backgroundColor: dashboardScreenController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.white,
        bottom: PreferredSize(
          preferredSize: const Size(0.0, 0.0),
          child: TabBar(
            isScrollable: false,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            controller: controller.tabController,
            indicatorColor: dashboardScreenController.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.colorPrimary,
            unselectedLabelColor:
                dashboardScreenController.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
            labelColor: dashboardScreenController.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.colorPrimary,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                    color: dashboardScreenController.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.colorPrimary,
                    width: 2.0),
                insets: const EdgeInsets.symmetric(horizontal: 16.0)),
            tabs: <Tab>[
              Tab(text: 'home'.tr),
              Tab(text: 'state'.tr),
              Tab(text: 'national'.tr),
              Tab(text: 'international'.tr),
            ],
          ),
        ),
      ),
    );
  }
}
