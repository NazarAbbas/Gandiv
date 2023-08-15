import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../route_management/routes.dart';
import '../../controllers/dashboard_page_cotroller.dart';
import '../../../constants/values/app_images.dart';

class DrawerSupport extends GetView<DashboardPageController> {
  const DrawerSupport({super.key, required this.context});
  final BuildContext context;
  final bool isDarkTheme = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _supportTitleContainer(),
        _emailSupportContainer(),
        const SizedBox(height: 10),
        _aboutUsContainer(),
        // Divider(
        //   color: controller.isDarkTheme.value == true
        //       ? AppColors.white
        //       : AppColors.black,
        // )
        const SizedBox(height: 10),
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

  Column _emailSupportContainer() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            Get.back();
            String email = Uri.encodeComponent("mail@fluttercampus.com");
            String subject = Uri.encodeComponent("Hello Flutter");
            String body = Uri.encodeComponent("Hi! I'm Flutter Developer");
            Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
            if (await launchUrl(mail)) {
              if (kDebugMode) {
                print("email app is  opened");
              }
            } else {
              if (kDebugMode) {
                print("email app is not opened");
              }
            }
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
                      AppImages.email,
                      height: 30,
                      width: 30,
                      color: controller.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'email_support'.tr,
                        style: TextStyle(
                            color: controller.isDarkTheme.value == true
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _aboutUsContainer() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            Get.back();
            Get.toNamed(Routes.aboutUsPage);
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
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.aboutUs,
                          height: 30,
                          width: 30,
                          color: controller.isDarkTheme.value == true
                              ? Colors.white
                              : Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "about_us".tr,
                            style: TextStyle(
                                color: controller.isDarkTheme.value == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _supportTitleContainer() {
    return Container(
      height: 50,
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
            'support'.tr,
            style: TextStyle(
              color: controller.isDarkTheme.value == true
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
