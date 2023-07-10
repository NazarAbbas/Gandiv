import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/login_page_cotroller.dart';
import 'package:get/get.dart';

import '../../../constants/dialog_utils.dart';
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
        backgroundColor: AppColors.colorPrimary,
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
                    mobileNumberWidget(),
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
                              primary: AppColors.colorPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1))),
                          child: Text(
                            'login'.tr,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.signupPage);
                          },
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
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
                        )),
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
    // Utils(context).showDiaolg(
    //     'title', 'message', 'hello', 'hi', okButtonPress, cancelButtonPress);
    // await Future.delayed(const Duration(seconds: 2));
    // controller.onLogin();
    // ignore: use_build_context_synchronously
    // Utils(context).stopLoading();

    DialogUtils.showThreeButtonCustomDialog(
      context: context,
      title: "Photo!",
      message: "message",
      firstButtonText: "CAMERA",
      secondButtonText: "GALLERY",
      thirdButtonText: "CANCEL",
      firstBtnFunction: () {
        Navigator.of(context).pop();
      },
      secondBtnFunction: () {
        Navigator.of(context).pop();
      },
      thirdBtnFunction: () {
        Navigator.of(context).pop();
      },
    );

    // showCustomDialog(context);
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 240,
            child: SizedBox.expand(child: FlutterLogo()),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
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

  Padding mobileNumberWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
      child: TextFormField(
        onChanged: (text) {
          controller.isEmailValid();
        },
        controller: controller.emailOrPhoneController,
        validator: (emailOrMobileNumer) {
          return controller.isEmailValid();
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
          labelText: 'mobileNumber'.tr,
          hintText: 'mobileNumber'.tr,
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
