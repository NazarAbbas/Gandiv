import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/upload_news_page_controller.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/dialog_utils.dart';
import '../../../constants/utils.dart';

// ignore: must_be_immutable
class UploadNewsPage extends GetView<UploadNewsPagePageController> {
  UploadNewsPage({super.key});
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  var locationId = "";

  // String dropdownvalue = 'Please select location';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          title: Text('upload_news'.tr),
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
                        subHeadingWidget(),
                        descriptionWidget(),
                        imagesWidget(context),
                        categoriesDropDownWidget(),
                        locationDropDownWidget()
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

  Padding imagesWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: AppColors.colorPrimary, spreadRadius: 1),
                ],
              ),
              width: double.infinity,
              height: 200,
              child: corauselWidget(context)),
          GestureDetector(
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: AppColors.colorPrimary, spreadRadius: 1),
                ],
              ),
              width: double.infinity,
              height: 35,
              child: Center(
                child: Text(
                  'upload_image'.tr,
                  style: TextStyle(color: AppColors.colorPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void uploadttonClick(BuildContext context) async {
    Utils(context).startLoading();
    //await Future.delayed(const Duration(seconds: 2));
    await controller.onUpload();
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
          controller.isHeadingValid();
        },
        controller: controller.headingController,
        validator: (firstName) {
          return controller.isHeadingValid();
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
          controller.isSubHeadingValid();
        },
        controller: controller.subHeadingController,
        validator: (firstName) {
          return controller.isSubHeadingValid();
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
        controller: controller.descriptionController,
        validator: (password) {
          return controller.isDescriptionValid();
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
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Padding locationDropDownWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: GFDropdown(
            hint: Text('please_select_location'.tr),
            padding: const EdgeInsets.all(0),
            borderRadius: BorderRadius.circular(5),
            border: const BorderSide(color: Colors.black12, width: 1),
            dropdownButtonColor: Colors.white,
            value: controller.locationDropdownValue.value,
            onChanged: (newValue) async {
              controller.locationDropdownValue.value = newValue!;
              final selectedId = await controller.appDatabase.locationsDao
                  .findLocationsIdByName(newValue);
              controller.locationDropdownSelectedID =
                  selectedId == null ? "" : selectedId.id!;
            },
            items: controller.locationList
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Padding categoriesDropDownWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: GFDropdown(
            hint: Text('please_select_category'.tr),
            padding: const EdgeInsets.all(0),
            borderRadius: BorderRadius.circular(5),
            border: const BorderSide(color: Colors.black12, width: 1),
            dropdownButtonColor: Colors.white,
            value: controller.categoriesDropdownValue.value,
            onChanged: (newValue) async {
              controller.categoriesDropdownValue.value = newValue!;
              final selectedId = await controller.appDatabase.categoriesDao
                  .findCategoriesIdByName(newValue);

              controller.categoriesDropdownSelectedID =
                  selectedId == null ? "" : selectedId.id;
            },
            items: controller.categoriesList
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
