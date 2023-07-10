import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/edit_profile_page_controller.dart';
import 'package:get/get.dart';
import '../../../constants/utils.dart';
import '../../../constants/values/app_images.dart';

// ignore: must_be_immutable
class EditProfilePage extends GetView<EditProfilePageController> {
  EditProfilePage({super.key});
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: Text('edit_profile'.tr),
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
                child: Column(
                  children: <Widget>[
                    topImageWidget(),
                    firstNameWidget(),
                    lastNameWidget(),
                    mobileNumberWidget(),
                    passwordWidget(),
                    //_userRoleContainer(),
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
                              primary: AppColors.colorPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1))),
                          child: Text(
                            'edit_profile'.tr,
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
    Utils(context).startLoading();
    await Future.delayed(const Duration(seconds: 2));
    controller.onSignup();
    // ignore: use_build_context_synchronously
    Utils(context).stopLoading();
    Get.back();
    Get.back();
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
        onChanged: (text) {
          controller.isFirstNameValid();
        },
        controller: controller.firstNameController,
        validator: (firstName) {
          return controller.isFirstNameValid();
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
        onChanged: (text) {
          controller.isLastNameValid();
        },
        controller: controller.lastNameController,
        validator: (firstName) {
          return controller.isLastNameValid();
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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

  // Obx _userRoleContainer() {
  //   return Obx(
  //     () => Padding(
  //       padding: const EdgeInsets.only(top: 10),
  //       child: Column(
  //         children: [
  //           RadioListTile(
  //             dense: true,
  //             visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
  //             title: Text('reporter'.tr),
  //             selectedTileColor:
  //                 dashboardPageController.isDarkTheme.value == true
  //                     ? AppColors.white
  //                     : AppColors.black,
  //             value: "Reporter",
  //             activeColor: dashboardPageController.isDarkTheme.value == true
  //                 ? AppColors.white
  //                 : AppColors.black,
  //             groupValue: controller.singleUserRoleValue.value,
  //             onChanged: (value) {
  //               controller.setUserRole(value.toString());
  //             },
  //           ),
  //           RadioListTile(
  //             dense: true,
  //             visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
  //             title: Text('user'.tr),
  //             selectedTileColor:
  //                 dashboardPageController.isDarkTheme.value == true
  //                     ? AppColors.white
  //                     : AppColors.black,
  //             value: "User",
  //             activeColor: dashboardPageController.isDarkTheme.value == true
  //                 ? AppColors.white
  //                 : AppColors.black,
  //             groupValue: controller.singleUserRoleValue.value,
  //             onChanged: (value) {
  //               controller.setUserRole(value.toString());
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
