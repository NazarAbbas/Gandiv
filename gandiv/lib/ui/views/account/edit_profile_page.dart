import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/edit_profile_page_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/dialog_utils.dart';
import '../../../constants/values/app_images.dart';

// ignore: must_be_immutable
class EditProfilePage extends GetView<EditProfilePageController> {
  EditProfilePage({super.key});
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          title: Text('edit_profile'.tr),
        ),
        body: controller.isLoading.value
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.transparent,
                child: const Center(child: CircularProgressIndicator()),
              )
            : Form(
                key: controller.formGlobalKey,
                child: Center(
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
                          topImageWidget(context),
                          firstNameWidget(),
                          lastNameWidget(),
                          mobileNumberWidget(),
                          emailWidget(),
                          //_userRoleContainer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 20, right: 20),
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
                                        borderRadius:
                                            BorderRadius.circular(1))),
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
    final response = await controller.executeUpdateProfile();
  }

  Stack topImageWidget(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              try {
                DialogUtils.showThreeButtonCustomDialog(
                  context: context,
                  title: 'photo!'.tr,
                  message: 'message'.tr,
                  firstButtonText: 'camera'.tr,
                  secondButtonText: 'gallery'.tr,
                  thirdButtonText: 'cancel'.tr,
                  firstBtnFunction: () {
                    Navigator.of(context).pop();
                    controller.openImage(ImageSource.camera);
                  },
                  secondBtnFunction: () {
                    Navigator.of(context).pop();
                    controller.openImage(ImageSource.gallery);
                  },
                  thirdBtnFunction: () {
                    Navigator.of(context).pop();
                  },
                );
              } catch (e) {
                if (kDebugMode) {
                  print("error while picking file.");
                }
              }
            },
            child: controller.croppedImagepath.isNotEmpty
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.file(
                        File(controller.croppedImagepath.value),
                        fit: BoxFit.fill,
                        width: 150.0,
                        height: 150.0,
                      ),
                    ),
                  )
                : controller.networkImagePath.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            AppImages.accountPersonIcon,
                            fit: BoxFit.fill,
                            width: 150,
                            height: 150,
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(20),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  controller.networkImagePath.value),
                              fit: BoxFit.fill),
                        ),
                      ),
          ),
        ),
        SizedBox(
          height: 110,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 120),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.edit,
                color: AppColors.colorPrimary,
              ),
            ),
          ),
        )
      ],
    );
  }

  Padding firstNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        onChanged: (text) {
          controller.isFirstNameValid();
        },
        controller: controller.firstNameController.value,
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
        controller: controller.lastNameController.value,
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

  Padding emailWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        controller: controller.emailController.value,
        validator: (password) {
          return controller.isEmailValid();
        },
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
          controller.isValidPhoneNumber();
        },
        controller: controller.phoneController.value,
        validator: (emailOrMobileNumer) {
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
