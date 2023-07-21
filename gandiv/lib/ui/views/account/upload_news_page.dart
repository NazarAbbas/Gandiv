import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/upload_news_page_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/dialog_utils.dart';
import '../../../constants/utils.dart';

// ignore: must_be_immutable
class UploadNewsPage extends GetView<UploadNewsPagePageController> {
  UploadNewsPage({super.key});
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          title: Text('upload'.tr),
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
                        headingWidget(),
                        //headingImage(context),
                        subHeadingWidget(),
                        //subheadingImage(context),
                        descriptionWidget(),
                        contentImage(context),
                        corauselWidget(context)

                        //_userRoleContainer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
            child: SizedBox(
              height: 60, //height of button
              width: double.infinity, //width of button
              child: ElevatedButton(
                onPressed: () {
                  uploadttonClick(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: AppColors.colorPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1))),
                child: Text(
                  'upload'.tr,
                ),
              ),
            ),
          ),
        ));
  }

  Padding headingImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                controller.openImage(
                    ImageSource.camera, ImageType.headingImage);
              },
              secondBtnFunction: () {
                Navigator.of(context).pop();
                controller.openImage(
                    ImageSource.gallery, ImageType.headingImage);
              },
              thirdBtnFunction: () {
                Navigator.of(context).pop();
              },
            );
          } catch (e) {
            print("error while picking file.");
          }
        },
        child: controller.headingCroppedImagepath.isNotEmpty
            ? Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.all(20),
                child: Image.file(
                  File(controller.headingCroppedImagepath.value),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: AppColors.colorPrimary, spreadRadius: 1),
                  ],
                ),
                width: double.infinity,
                height: 200,
                child: Center(
                  child: Text(
                    'Please upload heading image',
                    style: TextStyle(color: AppColors.colorPrimary),
                  ),
                ),
              ),
      ),
    );
  }

  Padding subheadingImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                controller.openImage(
                    ImageSource.camera, ImageType.subHeadingImage);
              },
              secondBtnFunction: () {
                Navigator.of(context).pop();
                controller.openImage(
                    ImageSource.gallery, ImageType.subHeadingImage);
              },
              thirdBtnFunction: () {
                Navigator.of(context).pop();
              },
            );
          } catch (e) {
            print("error while picking file.");
          }
        },
        child: controller.subHeadingCroppedImagepath.isNotEmpty
            ? Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.all(20),
                child: Image.file(
                  File(controller.subHeadingCroppedImagepath.value),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: AppColors.colorPrimary, spreadRadius: 1),
                  ],
                ),
                width: double.infinity,
                height: 200,
                child: Center(
                  child: Text(
                    'Please upload heading image',
                    style: TextStyle(color: AppColors.colorPrimary),
                  ),
                ),
              ),
      ),
    );
  }

  Padding contentImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                controller.openImage(
                    ImageSource.camera, ImageType.contentImage);
              },
              secondBtnFunction: () {
                Navigator.of(context).pop();
                controller.openImage(
                    ImageSource.gallery, ImageType.contentImage);
              },
              thirdBtnFunction: () {
                Navigator.of(context).pop();
              },
            );
          } catch (e) {
            print("error while picking file.");
          }
        },
        child: controller.contentCroppedImagepath.isNotEmpty
            ? Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.all(20),
                child: Image.file(
                  File(controller.contentCroppedImagepath.value),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: AppColors.colorPrimary, spreadRadius: 1),
                  ],
                ),
                width: double.infinity,
                height: 200,
                child: Center(
                  child: Text(
                    'Please upload heading image',
                    style: TextStyle(color: AppColors.colorPrimary),
                  ),
                ),
              ),
      ),
    );
  }

  void uploadttonClick(BuildContext context) async {
    Utils(context).startLoading();
    await Future.delayed(const Duration(seconds: 2));
    controller.onUpload();
    // ignore: use_build_context_synchronously
    Utils(context).stopLoading();
    // Get.back();
    // Get.back();
  }

  Padding headingWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        maxLines: 2,
        onChanged: (text) {
          controller.isFirstNameValid();
        },
        controller: controller.firstNameController,
        validator: (firstName) {
          return controller.isFirstNameValid();
        },
        keyboardType: TextInputType.text,
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
          labelText: 'heading'.tr,
          hintText: 'heading'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          // prefixIcon: Icon(Icons.person,
          //     color: dashboardPageController.isDarkTheme.value == true
          //         ? Colors.white
          //         : AppColors.colorPrimary),
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

  Padding subHeadingWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        maxLines: 3,
        onChanged: (text) {
          controller.isLastNameValid();
        },
        controller: controller.lastNameController,
        validator: (firstName) {
          return controller.isLastNameValid();
        },
        keyboardType: TextInputType.text,
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
          labelText: 'sub_heading'.tr,
          hintText: 'sub_heading'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          // prefixIcon: Icon(Icons.person,
          //     color: dashboardPageController.isDarkTheme.value == true
          //         ? Colors.white
          //         : AppColors.colorPrimary),
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

  Padding descriptionWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        maxLines: 5,
        keyboardType: TextInputType.text,
        controller: controller.passwordController,
        validator: (password) {
          return controller.isPasswordValid();
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
          labelText: 'description'.tr,
          hintText: 'description'.tr,
          hintStyle: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? Colors.white
                  : AppColors.colorPrimary),
          labelStyle: TextStyle(
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

  Padding corauselWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CarouselSlider(
        options: CarouselOptions(
            pauseAutoPlayOnTouch: true,
            autoPlay: false,
            height: MediaQuery.of(context).size.width * (3 / 4),
            enlargeCenterPage: true),
        items: controller.imageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Image.file(
                File(i),
                fit: BoxFit.fill,
                width: 100.0,
                height: 100.0,
              );
            },
          );
        }).toList(),
      ),

      // child: Image.network(
      //   controller.newsList[index].mediaList[0].url ??
      //       'https://avatars.githubusercontent.com/u/1?v=4"',

      //   height: MediaQuery.of(context).size.width * (3 / 4),
      //   width: MediaQuery.of(context).size.width,
      //   loadingBuilder: (BuildContext context, Widget child,
      //       ImageChunkEvent? loadingProgress) {
      //     if (loadingProgress == null) return child;
      //     return Center(
      //       child: CircularProgressIndicator(
      //         value: loadingProgress.expectedTotalBytes != null
      //             ? loadingProgress.cumulativeBytesLoaded /
      //                 loadingProgress.expectedTotalBytes!
      //             : null,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
