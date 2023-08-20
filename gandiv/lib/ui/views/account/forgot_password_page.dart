import 'package:flutter/material.dart';
import 'package:gandiv/constants/dialog_utils.dart';
import 'package:gandiv/constants/utils.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/forgot_password_page_controller.dart';
import 'package:get/get.dart';

import '../../../constants/values/app_images.dart';
import '../../../route_management/routes.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends GetView<ForgotPasswordPageController> {
  ForgotPasswordPage({super.key});

  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.colorPrimary,
        title: Text('forgot_password'.tr),
      ),
      body: Form(
        key: controller.formGlobalKey,
        child: Obx(
          () => Center(
            child: Container(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.dartTheme
                  : AppColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: <Widget>[
                    topImageWidget(),
                    emailWidget(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: SizedBox(
                        height: 60, //height of button
                        width: double.infinity, //width of button
                        child: ElevatedButton(
                          onPressed: () {
                            sendButtonClick(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary:
                                  dashboardPageController.isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : AppColors.colorPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1))),
                          child: Text(
                            style: TextStyle(
                                color:
                                    dashboardPageController.isDarkTheme.value ==
                                            true
                                        ? AppColors.black
                                        : AppColors.white),
                            'send'.tr,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendButtonClick(BuildContext context) async {
    final response = await controller.onForgotPassword();
    // ignore: use_build_context_synchronously
    //Utils(context).stopLoading();
    // if (response == null) {
    // } else {
    //   // ignore: use_build_context_synchronously
    //   if (response != null && response.status != 200) {
    //     // ignore: use_build_context_synchronously
    //     DialogUtils.showSingleButtonCustomDialog(
    //       context: context,
    //       title: 'error'.tr,
    //       message: response.message,
    //       firstButtonText: 'OK',
    //       firstBtnFunction: () {
    //         Navigator.of(context).pop();
    //       },
    //     );
    //   } else if (response.status == 200) {
    //     {
    //       // ignore: use_build_context_synchronously
    //       DialogUtils.showSingleButtonCustomDialog(
    //         context: context,
    //         title: 'Alert'.tr,
    //         message: response.message,
    //         firstButtonText: 'OK',
    //         firstBtnFunction: () {
    //           Navigator.of(context).pop();
    //           Get.back();
    //         },
    //       );
    //     }
    //   }
    // }
  }

  Image topImageWidget() {
    return Image.asset(
      AppImages.appLogo,
      fit: BoxFit.contain,
      color: dashboardPageController.isDarkTheme.value == true
          ? AppColors.white
          : AppColors.black,
    );
  }

  Padding emailWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
      child: TextFormField(
        onChanged: (text) {
          controller.isValidEmail();
        },
        controller: controller.emailController,
        validator: (emailOrMobileNumer) {
          return controller.isValidEmail();
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: dashboardPageController.isDarkTheme.value == true
                      ? Colors.white
                      : AppColors.colorPrimary)),
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: dashboardPageController.isDarkTheme.value == true
                      ? Colors.white
                      : AppColors.colorPrimary)),
          labelText: 'email'.tr,
          hintText: 'email'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          prefixIcon: Icon(Icons.email,
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: dashboardPageController.isDarkTheme.value == true
                      ? Colors.white
                      : AppColors.colorPrimary)),
        ),
      ),
    );
  }
}
