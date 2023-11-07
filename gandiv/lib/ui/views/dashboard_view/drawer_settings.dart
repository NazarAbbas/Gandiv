import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gandiv/constants/constant.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/constants/values/size_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../constants/enums.dart';
import '../../controllers/dashboard_page_cotroller.dart';
import '../../../constants/values/app_images.dart';
import 'dashboard_page.dart';

class DrawerSettings extends GetView<DashboardPageController> {
  const DrawerSettings(
      {super.key, required this.context, required this.callback});
  final BuildContext context;
  final MyCallback callback;
  final bool isDarkTheme = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _settingTitleContainer(),
        _settingLanguageContainer(),
        //const SizedBox(height: 10),
        //  _settingLocationTitle(),
        const SizedBox(height: 10),
        _settingThemeTitle(),
        const SizedBox(height: 10),
        // Divider(
        //   color: controller.isDarkTheme.value == true
        //       ? AppColors.white
        //       : AppColors.black,
        // )
        Container(
          width: double.infinity,
          height: .5,
          color: controller.isDarkTheme.value == true
              ? AppColors.white
              : AppColors.black,
        ),
      ],
    );
  }

  Column _settingLocationTitle() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.isLocationVisible();
          },
          child: Container(
            height: 40,
            width: double.infinity,
            color: controller.isDarkTheme.value == true
                ? AppColors.dartTheme
                : AppColors.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.sideMenuLocationIcon,
                      height: 30,
                      width: 30,
                      color: controller.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'location'.tr,
                        style: TextStyle(
                            color: controller.isDarkTheme.value == true
                                ? AppColors.white
                                : AppColors.black,
                            fontSize:
                                SizeConfig.navigationDrawerHeadingFontSize),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      color: controller.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        _locationOptionsContainer(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Obx _settingThemeTitle() {
    return Obx(
      () => Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            color: controller.isDarkTheme.value == true
                ? AppColors.dartTheme
                : AppColors.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.theme,
                      height: 30,
                      width: 30,
                      color: controller.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'theme'.tr,
                        style: TextStyle(
                            fontSize:
                                SizeConfig.navigationDrawerHeadingFontSize),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FlutterSwitch(
                        width: 70.0,
                        height: 45.0,
                        value: controller.isDarkTheme.value,
                        borderRadius: 30.0,
                        padding: 2.0,
                        activeToggleColor: const Color(0xFFFFFFFF),
                        inactiveToggleColor: const Color(0xFF2F363D),
                        activeSwitchBorder: Border.all(
                          color: const Color(0xFFD1D5DA), //Color(0xFF3C1E70),
                          width: 6.0,
                        ),
                        inactiveSwitchBorder: Border.all(
                          color: const Color(0xFFD1D5DA),
                          width: 6.0,
                        ),
                        activeColor: const Color(0xFF121212),
                        inactiveColor: Colors.white,
                        activeIcon: const Icon(
                          Icons.nightlight_round,
                          color: Color(0xFFF8E3A1),
                        ),
                        inactiveIcon: const Icon(
                          Icons.wb_sunny,
                          color: Color(0xFFFFDF5D),
                        ),
                        onToggle: (val) {
                          // Get.changeTheme(
                          //   Get.isDarkMode
                          //       ? ThemeData.light()
                          //       : ThemeData.dark(),
                          // );
                          Get.changeTheme(GetStorage()
                                      .read(Constant.selectedLanguage) ==
                                  Language.english
                              ? Get.isDarkMode
                                  ? ThemeData(
                                      brightness: Brightness.light,
                                      fontFamily:
                                          AppFontFamily.englishFontStyle,
                                    )
                                  : ThemeData(
                                      brightness: Brightness.dark,
                                      fontFamily:
                                          AppFontFamily.englishFontStyle,
                                    )
                              : Get.isDarkMode
                                  ? ThemeData(
                                      brightness: Brightness.light,
                                      fontFamily: AppFontFamily.hindiFontStyle,
                                    )
                                  : ThemeData(
                                      brightness: Brightness.dark,
                                      fontFamily: AppFontFamily.hindiFontStyle,
                                    ));
                          controller.setTheme(val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Obx _languageOptionsContainer() {
    return Obx(
      () => Visibility(
        visible: controller.isLangVisible.value,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              RadioListTile(
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                title: Text(
                  'हिंदी',
                  style: TextStyle(
                      color: controller.isDarkTheme.value == true
                          ? Colors.white
                          : Colors.black,
                      fontSize: SizeConfig.navigationDrawerOptionFontSize),
                ),
                selectedTileColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                value: "Hindi",
                activeColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                groupValue: controller.singleLanguageValue.value,
                onChanged: (value) {
                  DashboardPageController dashboardPageController =
                      Get.find<DashboardPageController>();
                  dashboardPageController.setTabbarIndex(0);
                  Get.updateLocale(
                      Locale(Constant.hindiLanguage, Constant.hindiCountry));
                  controller.selectLanguage(value.toString());
                  closeNavigationDrawer();
                  GetStorage().write(Constant.selectedLanguage, Language.hindi);
                  Get.changeTheme(ThemeData(
                    brightness: Get.isDarkMode == true
                        ? Brightness.dark
                        : Brightness.light,
                    fontFamily: AppFontFamily.hindiFontStyle,
                  ));

                  callback();
                },
              ),
              RadioListTile(
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                title: Text(
                  "English",
                  style: TextStyle(
                      color: controller.isDarkTheme.value == true
                          ? Colors.white
                          : Colors.black,
                      fontSize: SizeConfig.navigationDrawerOptionFontSize),
                ),
                selectedTileColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                value: "English",
                activeColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                groupValue: controller.singleLanguageValue.value,
                onChanged: (value) {
                  Get.updateLocale(Locale(
                      Constant.englishLanguage, Constant.englishCountry));
                  controller.selectLanguage(value.toString());
                  closeNavigationDrawer();
                  GetStorage()
                      .write(Constant.selectedLanguage, Language.english);
                  Get.changeTheme(
                    ThemeData(
                      brightness: Get.isDarkMode == true
                          ? Brightness.dark
                          : Brightness.light,
                      fontFamily: AppFontFamily.englishFontStyle,
                    ),
                  );
                  callback();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Obx _locationOptionsContainer() {
    return Obx(
      () => Visibility(
        visible: controller.isLocVisible.value,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              RadioListTile(
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                title: Text(
                  'varansi'.tr,
                  style: TextStyle(
                      color: controller.isDarkTheme.value == true
                          ? Colors.white
                          : Colors.black,
                      fontSize: SizeConfig.navigationDrawerOptionFontSize),
                ),
                selectedTileColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                value: "Varansi",
                activeColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                groupValue: controller.singleLocationValue.value,
                onChanged: (value) {
                  callback();
                  GetStorage()
                      .write(Constant.selectedLocation, Location.varanasi);
                  controller.selectLocation(value.toString());
                  closeNavigationDrawer();
                },
              ),
              RadioListTile(
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                title: Text(
                  'agra'.tr,
                  style: TextStyle(
                      color: controller.isDarkTheme.value == true
                          ? Colors.white
                          : Colors.black,
                      fontSize: SizeConfig.navigationDrawerOptionFontSize),
                ),
                selectedTileColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                value: "Agra",
                activeColor: controller.isDarkTheme.value == true
                    ? AppColors.white
                    : AppColors.black,
                groupValue: controller.singleLocationValue.value,
                onChanged: (value) {
                  callback();
                  GetStorage().write(Constant.selectedLocation, Location.agra);
                  controller.selectLocation(value.toString());
                  closeNavigationDrawer();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _settingLanguageContainer() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.isLanguageVisible();
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: double.infinity,
                color: controller.isDarkTheme.value == true
                    ? AppColors.dartTheme
                    : AppColors.white,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.languageIcon,
                          height: 20,
                          width: 20,
                          color: controller.isDarkTheme.value == true
                              ? Colors.white
                              : Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "language".tr,
                            style: TextStyle(
                                color: controller.isDarkTheme.value == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: SizeConfig
                                    .navigationDrawerSubHeadingFontSize),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_drop_down,
                          color: controller.isDarkTheme.value == true
                              ? AppColors.white
                              : AppColors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _languageOptionsContainer(),
      ],
    );
  }

  Container _settingTitleContainer() {
    return Container(
      height: 40,
      width: double.infinity,
      color: controller.isDarkTheme.value == true
          ? AppColors.dartTheme
          : AppColors.lightGray,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            textAlign: TextAlign.left,
            'setting'.tr,
            style: TextStyle(
              color: controller.isDarkTheme.value == true
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.newsHeadingTitleSize,
            ),
          ),
        ),
      ),
    );
  }

  void closeNavigationDrawer() {
    Get.back();
  }
}
