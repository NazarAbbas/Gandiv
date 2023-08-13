import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/get.dart';
import '../../../route_management/routes.dart';
import '../../controllers/dashboard_page_cotroller.dart';
import '../../../constants/values/app_images.dart';
import 'dashboard_page.dart';

class DrawerAccount extends GetView<DashboardPageController> {
  const DrawerAccount(
      {super.key, required this.context, required MyCallback this.callback});
  final BuildContext context;
  final MyCallback callback;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _accountTitleContainer(),
        _loginLogoutContainer(),
        // Divider(
        //   color: controller.isDarkTheme.value == true
        //       ? AppColors.white
        //       : AppColors.black,
        // )
      ],
    );
  }

  Column _loginLogoutContainer() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            Get.back();
            Get.toNamed(Routes.loginScreen)?.then(
              (value) => {callback()},
            );
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
                          AppImages.loginLogout,
                          height: 30,
                          width: 30,
                          color: controller.isDarkTheme.value == true
                              ? Colors.white
                              : Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "loginLogout".tr,
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

  Container _accountTitleContainer() {
    return Container(
      padding: EdgeInsets.zero,
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
            'account'.tr,
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
