import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_images.dart';
import 'package:gandiv/models/profile_db_model.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/values/app_colors.dart';
import '../../database/app_database.dart';

class ProfilePageController extends GetxController {
  ImagePicker imgpicker = ImagePicker();
  final localImagePath = "".obs;
  final networkImagePath = "".obs;
  final croppedImagepath = "".obs;
  final mobileNumber = "".obs;
  final email = "".obs;
  late RxBool isLogin = false.obs;
  late File imagefile;
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  late List<ProfileData> profile;

  @override
  void onInit() async {
    super.onInit();
    await appDatabase.profileDao.findProfile();
    profile = await appDatabase.profileDao.findProfile();
    if (profile.isNotEmpty) {
      isLogin.value = true;
      final mobileNo = profile[0].mobileNo;
      final emailData = profile[0].email;
      if (mobileNo == null || mobileNo.isEmpty) {
        mobileNumber.value = "+91 XXXXXXXXXX";
      } else {
        mobileNumber.value = "+91 $mobileNo";
      }
      if (emailData!.isEmpty) {
        email.value = 'xxx@gmail.com';
      } else {
        email.value = emailData;
      }

      final profileImage = profile[0].profileImage;
      networkImagePath.value = profileImage ?? AppImages.notification;
    } else {
      isLogin.value = false;
      mobileNumber.value = "+91 XXXXXXXXXX";
      email.value = 'XXXXX@gmail.com';
    }
  }

  void openImage(ImageSource imageSource) async {
    try {
      var pickedFile = await imgpicker.pickImage(source: imageSource);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
        imagefile = File(localImagePath.value);
        cropImage();
      } else {
        if (kDebugMode) {
          print("No image is selected.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while picking file.");
      }
    }
  }

  void openCamera() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
        imagefile = File(localImagePath.value);
        cropImage();
      } else {
        if (kDebugMode) {
          print("No image is selected.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while picking file.");
      }
    }
  }

  void cropImage() async {
    File? croppedfile = (await ImageCropper().cropImage(
        sourcePath: localImagePath.value,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: AppColors.colorPrimary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        )));

    if (croppedfile != null) {
      imagefile = croppedfile;
      croppedImagepath.value = croppedfile.path;
      //setState(() { });
    } else {
      if (kDebugMode) {
        print("Image is not cropped.");
      }
    }
  }
}
