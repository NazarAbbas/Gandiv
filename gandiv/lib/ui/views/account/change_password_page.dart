import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:get/get.dart';
import '../../../constants/values/app_images.dart';
import '../../controllers/change_password_page_cotroller.dart';

// ignore: must_be_immutable
class ChangePassswordPage extends GetView<ChangePasswordPageController> {
  ChangePassswordPage({super.key});

  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.colorPrimary,
        title: Text('change_password'.tr),
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
                    oldPasswordWidget(),
                    newPasswordWidget(),
                    confirmPasswordWidget(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: SizedBox(
                        height: 60, //height of button
                        width: double.infinity, //width of button
                        child: ElevatedButton(
                          onPressed: () {
                            changePasswordButtonClick(context);
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
                            'change_password'.tr,
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

  void changePasswordButtonClick(BuildContext context) async {
    final response = await controller.onChangePassword();
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

  Padding oldPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextFormField(
        controller: controller.passwordController,
        validator: (password) {
          return controller.isPasswordValid();
        },
        obscureText: controller.isPasswordVisible.value,
        obscuringCharacter: "*",
        enableSuggestions: false,
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
          labelText: 'password'.tr,
          hintText: 'password'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          prefixIcon: Icon(Icons.password,
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          suffixIcon: IconButton(
            icon: Icon(
                // Based on passwordVisible state choose the icon
                // ignore: dead_code
                controller.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: dashboardPageController.isDarkTheme.value == true
                    ? Colors.white
                    : AppColors.colorPrimary),
            onPressed: () {
              controller
                  .setPasswordVisible(!controller.isPasswordVisible.value);
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: dashboardPageController.isDarkTheme.value == true
                    ? Colors.white
                    : AppColors.colorPrimary),
          ),
        ),
      ),
    );
  }

  Padding newPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextFormField(
        controller: controller.newPasswordController,
        validator: (password) {
          return controller.isNewPasswordValid();
        },
        obscureText: controller.isNewPasswordVisible.value,
        obscuringCharacter: "*",
        enableSuggestions: false,
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
          labelText: 'new_password'.tr,
          hintText: 'new_password'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          prefixIcon: Icon(Icons.password,
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          suffixIcon: IconButton(
            icon: Icon(
                // Based on passwordVisible state choose the icon
                // ignore: dead_code
                controller.isNewPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: dashboardPageController.isDarkTheme.value == true
                    ? Colors.white
                    : AppColors.colorPrimary),
            onPressed: () {
              controller.setNewPasswordVisible(
                  !controller.isNewPasswordVisible.value);
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: dashboardPageController.isDarkTheme.value == true
                    ? Colors.white
                    : AppColors.colorPrimary),
          ),
        ),
      ),
    );
  }

  Padding confirmPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextFormField(
        controller: controller.confirmPasswordController,
        validator: (password) {
          return controller.isConfirmPasswordValid();
        },
        obscureText: controller.isConfirmPasswordVisible.value,
        obscuringCharacter: "*",
        enableSuggestions: false,
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
          labelText: 'confirm_password'.tr,
          hintText: 'confirm_password'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          prefixIcon: Icon(Icons.password,
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          suffixIcon: IconButton(
            icon: Icon(
                // Based on passwordVisible state choose the icon
                // ignore: dead_code
                controller.isConfirmPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: dashboardPageController.isDarkTheme.value == true
                    ? Colors.white
                    : AppColors.colorPrimary),
            onPressed: () {
              controller.setConfirmPasswordVisible(
                  !controller.isConfirmPasswordVisible.value);
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: dashboardPageController.isDarkTheme.value == true
                    ? Colors.white
                    : AppColors.colorPrimary),
          ),
        ),
      ),
    );
  }
}
