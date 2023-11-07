import 'package:flutter/material.dart';
import 'package:gandiv/constants/constant.dart';
import 'package:gandiv/constants/enums.dart';
import 'package:gandiv/constants/values/size_config.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/home_page_contoller.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/categories_response.dart';
import '../news_views/home_news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

// ignore: must_be_immutable
class HomePageState extends State<HomePage> {
  DashboardPageController dashboardScreenController =
      Get.find<DashboardPageController>();

  HomePageController controller = Get.find<HomePageController>();

  // final List<Widget> _bottomBarWidgets = <Widget>[
  //   const HomeNewsPage(),
  //   // const StateNewsPage(),
  //   // const NationalNewsPage(),
  //   // const InterNationalNewsPage()
  // ];

  void refreshPage() async {
    HomeNewsPageListRow("").refreshPage();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isDataLoading.value
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.transparent,
              child: const Center(child: CircularProgressIndicator()),
            )
          : Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: buildAppBar(),
              ),
              //New Dynamic code
              body: TabBarView(
                controller: controller.tabController,
                children: [
                  for (Categories title in controller.catgories)
                    HomeNewsPage(categoryId: title.id),
                ],
              ),
              // Dynamic code  End
              // OLD/Static code
              // body: TabBarView(
              //     controller: controller.tabController, children: _bottomBarWidgets),
              //OLD/Static code End
            ),
    );
  }

  AppBar buildAppBar() {
    var isScrollable = false;
    if (GetStorage().read(Constant.selectedLanguage) == Language.hindi) {
      if (controller.tabsLength <= 4) {
        isScrollable = false;
      } else {
        isScrollable = true;
      }
    }
    if (GetStorage().read(Constant.selectedLanguage) == Language.english) {
      if (controller.tabsLength <= 4) {
        isScrollable = false;
      } else {
        isScrollable = true;
      }
    }
    return AppBar(
      backgroundColor: dashboardScreenController.isDarkTheme.value == true
          ? AppColors.dartTheme
          : AppColors.white,
      bottom: PreferredSize(
        preferredSize: const Size(0.0, 0.0),
        child: TabBar(
          labelStyle: TextStyle(
            fontSize:
                GetStorage().read(Constant.selectedLanguage) == Language.hindi
                    ? SizeConfig.hindiTabSize
                    : SizeConfig.englishTabSize,
            fontFamily:
                GetStorage().read(Constant.selectedLanguage) == Language.hindi
                    ? AppFontFamily.hindiFontStyle
                    : AppFontFamily.englishFontStyle,
          ),
          isScrollable: isScrollable,
          labelPadding: controller.tabsLength <= 4
              ? const EdgeInsets.symmetric(horizontal: 10.0)
              : const EdgeInsets.symmetric(horizontal: 15.0),
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
            //Dynamic code
            for (Categories title in controller.catgories)
              // ignore: unrelated_type_equality_checks
              controller.languageId == Language.hindi
                  ? Tab(text: title.hindiName)
                  : Tab(text: title.name),
            //Dynamic code End

            //OLD/ Static code
            // Tab(text: 'home'.tr),
            // Tab(text: 'state'.tr),
            // Tab(text: 'national'.tr),
            // Tab(text: 'international'.tr),
            //OLD/Static code End
          ],
        ),
      ),
    );
  }
}
