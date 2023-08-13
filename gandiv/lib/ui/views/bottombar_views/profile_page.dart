import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/profile_page_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/dialog_utils.dart';
import '../../../constants/values/app_images.dart';
import '../../../database/app_database.dart';
import '../../../route_management/routes.dart';
import '../../controllers/comman_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: InterNationalNewsPageListRow(),
  //       // body: Obx(
  //       //   () => controller.isDataLoading.value || controller.newsList.isEmpty
  //       //       ? Container(
  //       //           width: double.infinity,
  //       //           height: double.infinity,
  //       //           color: AppColors.transparent,
  //       //           child: const Center(child: CircularProgressIndicator()))
  //       //       : HomeNewsPageListRow(),
  //       // ),
  //     ),
  //   );
  //}
  @override
  ProfilePageState createState() => ProfilePageState();
}

// ignore: must_be_immutable
class ProfilePageState extends State<ProfilePage> {
  // ProfilePage({super.key});
  CommanController commanController = Get.find<CommanController>();
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  late File imagefile;

  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();
  ProfilePageController controller = Get.find<ProfilePageController>();
  @override
  void initState() {
    super.initState();
    //controller.newsList.clear();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          color: dashboardPageController.isDarkTheme.value == true
              ? AppColors.dartTheme
              : AppColors.white,
          child: Column(
            children: [
              // Visibility(
              //   visible: controller.isLogin.value,
              //   child: Column(
              //     children: [
              //       Stack(
              //         children: [
              //           Center(
              //             child: GestureDetector(
              //               onTap: () {
              //                 try {
              //                   DialogUtils.showThreeButtonCustomDialog(
              //                     context: context,
              //                     title: 'photo!'.tr,
              //                     message: 'message'.tr,
              //                     firstButtonText: 'camera'.tr,
              //                     secondButtonText: 'gallery'.tr,
              //                     thirdButtonText: 'cancel'.tr,
              //                     firstBtnFunction: () {
              //                       Navigator.of(context).pop();
              //                       controller.openImage(ImageSource.camera);
              //                     },
              //                     secondBtnFunction: () {
              //                       Navigator.of(context).pop();
              //                       controller.openImage(ImageSource.gallery);
              //                     },
              //                     thirdBtnFunction: () {
              //                       Navigator.of(context).pop();
              //                     },
              //                   );
              //                 } catch (e) {
              //                   if (kDebugMode) {
              //                     print("error while picking file.");
              //                   }
              //                 }
              //               },
              //               child: controller.networkImagePath.isEmpty
              //                   ? Container(
              //                       alignment: Alignment.center,
              //                       margin: const EdgeInsets.all(20),
              //                       child: ClipRRect(
              //                         borderRadius:
              //                             BorderRadius.circular(100.0),
              //                         child: Image.asset(
              //                           controller.networkImagePath.value,
              //                           fit: BoxFit.fill,
              //                           width: 100,
              //                           height: 100,
              //                         ),
              //                       ),
              //                     )
              //                   : Container(
              //                       alignment: Alignment.center,
              //                       margin: const EdgeInsets.all(20),
              //                       width: 100,
              //                       height: 100,
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.circle,
              //                         image: DecorationImage(
              //                             image: NetworkImage(controller
              //                                 .networkImagePath.value),
              //                             fit: BoxFit.fill),
              //                       ),
              //                     ),
              //             ),
              //           ),
              //           SizedBox(
              //             height: 110,
              //             child: Padding(
              //               padding: const EdgeInsets.only(left: 30),
              //               child: Align(
              //                 alignment: Alignment.bottomCenter,
              //                 child: Icon(
              //                   Icons.edit,
              //                   color: AppColors.white,
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //       Text(
              //         controller.mobileNumber.value,
              //         style: TextStyle(
              //             fontSize: 16,
              //             color:
              //                 dashboardPageController.isDarkTheme.value == true
              //                     ? AppColors.white
              //                     : AppColors.black),
              //       ),
              //       Text(
              //         controller.email.value,
              //         style: TextStyle(
              //             fontSize: 16,
              //             color:
              //                 dashboardPageController.isDarkTheme.value == true
              //                     ? AppColors.white
              //                     : AppColors.black),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                  padding: const EdgeInsets.only(top: 20), child: divider()),
              notificationSettingWidget(),
              divider(),
              editProfileWidget(),
              divider(),
              Visibility(
                visible:
                    commanController.isNotLogedIn.value == true ? false : true,
                child: Column(
                  children: [
                    Visibility(
                        visible: commanController.userRole.value == "Reporter"
                            ? true
                            : true,
                        child: uploadNewsWidget(context)),
                    divider(),
                    logoutWidget(context),
                    divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
          width: double.infinity,
          height: .2,
          color: dashboardPageController.isDarkTheme.value == true
              ? AppColors.white
              : AppColors.black),
    );
  }

  GestureDetector notificationSettingWidget() {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(Routes.notificationPage),
      },
      child: Container(
        width: double.infinity,
        height: 60,
        color: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  'notificationSetting'.tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: dashboardPageController.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                const Spacer(),
                Image.asset(
                  AppImages.sideArrow,
                  height: 20,
                  width: 20,
                  color: dashboardPageController.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Visibility logoutWidget(BuildContext context) {
    return Visibility(
      visible: controller.isLogin.value,
      child: GestureDetector(
        onTap: () {
          try {
            DialogUtils.showTwoButtonCustomDialog(
              context: context,
              title: 'logout'.tr,
              message: 'logout_message'.tr,
              firstButtonText: 'no'.tr,
              secondButtonText: 'yes'.tr,
              firstBtnFunction: () {
                Navigator.of(context).pop();
              },
              secondBtnFunction: () async {
                final AppDatabase appDatabase = Get.find<AppDatabase>();
                await appDatabase.profileDao.deleteProfile();
                exit(0);
              },
            );
          } catch (e) {
            if (kDebugMode) {
              print("error while picking file.");
            }
          }
        },
        child: Container(
          width: double.infinity,
          height: 60,
          color: dashboardPageController.isDarkTheme.value == true
              ? AppColors.dartTheme
              : AppColors.lightGray,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    'logout'.tr,
                    style: TextStyle(
                        fontSize: 16,
                        color: dashboardPageController.isDarkTheme.value == true
                            ? AppColors.white
                            : AppColors.black),
                  ),
                  const Spacer(),
                  Image.asset(
                    AppImages.sideArrow,
                    height: 20,
                    width: 20,
                    color: dashboardPageController.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector editProfileWidget() {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(Routes.editProfilePage),
      },
      child: Container(
        width: double.infinity,
        height: 60,
        color: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.lightGray,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  'edit_profile'.tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: dashboardPageController.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                const Spacer(),
                Image.asset(
                  AppImages.sideArrow,
                  height: 20,
                  width: 20,
                  color: dashboardPageController.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector uploadNewsWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.uploadNewsPage);
      },
      child: Container(
        width: double.infinity,
        height: 60,
        color: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  'upload_news'.tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: dashboardPageController.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                const Spacer(),
                Image.asset(
                  AppImages.sideArrow,
                  height: 20,
                  width: 20,
                  color: dashboardPageController.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
