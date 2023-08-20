import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/login_page_cotroller.dart';
import 'package:get/get.dart';

import '../../../constants/values/app_images.dart';
import '../../../route_management/routes.dart';

// ignore: must_be_immutable
class LoginPage extends GetView<LoginPageController> {
  LoginPage({super.key});

  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.colorPrimary,
        title: Text('login'.tr),
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
                    passwordWidget(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                color:
                                    dashboardPageController.isDarkTheme.value ==
                                            true
                                        ? AppColors.black
                                        : AppColors.white),
                            'login'.tr,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.forgotPasswordPage);
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  dashboardPageController.isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : Colors.blue,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'forgot_password'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.signupPage);
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  dashboardPageController.isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : Colors.blue,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'new_user'.tr),
                              TextSpan(
                                  text: 'create_account'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
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

  void loginButtonClick(BuildContext context) async {
    // Utils(context).startLoading();

    final response = await controller.onLogin();
    // ignore: use_build_context_synchronously
    // Utils(context).stopLoading();
    // // ignore: use_build_context_synchronously
    // if (response != null && response.status != 200) {
    //   // ignore: use_build_context_synchronously
    //   DialogUtils.showSingleButtonCustomDialog(
    //     context: context,
    //     title: 'ERROR',
    //     message: response.message,
    //     firstButtonText: 'OK',
    //     firstBtnFunction: () {
    //       Navigator.of(context).pop();
    //     },
    //   );
    // } else if (response != null && response.status == 200) {
    //   {
    //     Get.back();
    //   }
    // }
  }

  Future updateProfilePic(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select any option'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {},
              child: const Text('open gallery'),
            ),
            SimpleDialogOption(
              onPressed: () {},
              child: const Text('open camera'),
            ),
          ],
        );
      },
    );
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

  Padding passwordWidget() {
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
}
