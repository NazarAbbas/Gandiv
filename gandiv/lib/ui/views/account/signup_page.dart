import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:get/get.dart';

import '../../../constants/dialog_utils.dart';
import '../../../constants/utils.dart';
import '../../../constants/values/app_images.dart';
import '../../controllers/signup_page_cotroller.dart';

// ignore: must_be_immutable
class SignupPage extends GetView<SignupPageController> {
  SignupPage({super.key});
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.colorPrimary,
        title: Text('signup'.tr),
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
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      topImageWidget(),
                      firstNameWidget(),
                      lastNameWidget(),
                      mobileNumberWidget(),
                      emailWidget(),
                      passwordWidget(),
                      _userRoleContainer(),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: SizedBox(
                          height: 60, //height of button
                          width: double.infinity, //width of button
                          child: ElevatedButton(
                            onPressed: () {
                              loginButtonClick(context);
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
                                  color: dashboardPageController
                                              .isDarkTheme.value ==
                                          true
                                      ? AppColors.black
                                      : AppColors.white),
                              'signup'.tr,
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
      ),
    );
  }

  void loginButtonClick(BuildContext context) async {
    /// Utils(context).startLoading();
    // await Future.delayed(const Duration(seconds: 2));
    final response = await controller.onSignup();
    // ignore: use_build_context_synchronously
    //  Utils(context).stopLoading();
    //  Get.back();
    //  Get.back();

    // if (response != null && response.status != 200) {
    //   // ignore: use_build_context_synchronously
    //   DialogUtils.showSingleButtonCustomDialog(
    //     context: context,
    //     title: 'ERROR',
    //     message: response?.message,
    //     firstButtonText: 'OK',
    //     firstBtnFunction: () {
    //       Navigator.of(context).pop();
    //     },
    //   );
    // } else if (response != null && response.status == 200) {
    //   {
    //     Get.back();
    //     Get.back();
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

  Padding firstNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onChanged: (text) {
          controller.isFirstNameValid();
        },
        controller: controller.firstNameController,
        validator: (firstName) {
          return controller.isFirstNameValid();
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
          labelText: 'first_name'.tr,
          hintText: 'first_name'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          prefixIcon: Icon(Icons.person,
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

  Padding lastNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onChanged: (text) {
          controller.isLastNameValid();
        },
        controller: controller.lastNameController,
        validator: (firstName) {
          return controller.isLastNameValid();
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
          labelText: 'last_name'.tr,
          hintText: 'last_name'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          prefixIcon: Icon(Icons.person,
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

  Padding passwordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.done,
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

  Padding emailWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onChanged: (text) {
          controller.isValidEmail();
        },
        controller: controller.emailController,
        validator: (emailOrMobileNumer) {
          return controller.isValidEmail();
        },
        keyboardType: TextInputType.emailAddress,
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

  Padding mobileNumberWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onChanged: (text) {
          controller.isValidPhoneNumber();
        },
        controller: controller.phoneNumberController,
        validator: (mobileNumer) {
          return controller.isValidPhoneNumber();
        },
        keyboardType: TextInputType.number,
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
          labelText: 'phoneNumber'.tr,
          hintText: 'phoneNumber'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          prefixIcon: Icon(Icons.mobile_friendly,
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

  Obx _userRoleContainer() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            RadioListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              title: Text('reporter'.tr),
              selectedTileColor:
                  dashboardPageController.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black,
              value: "3",
              activeColor: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.white
                  : AppColors.black,
              groupValue: controller.singleUserRoleValue.value,
              onChanged: (value) {
                controller.setUserRole(3.toString());
              },
            ),
            RadioListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              title: Text('reader'.tr),
              selectedTileColor:
                  dashboardPageController.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black,
              value: "4",
              activeColor: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.white
                  : AppColors.black,
              groupValue: controller.singleUserRoleValue.value,
              onChanged: (value) {
                controller.setUserRole(4.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
