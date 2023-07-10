import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/values/app_colors.dart';

class UploadNewsPagePageController extends GetxController {
  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  final singleUserRoleValue = "Reporter".obs;

  ImagePicker imgpicker = ImagePicker();
  final localImagePath = "".obs;
  final networkImagePath = "".obs;
  final headingCroppedImagepath = "".obs;
  final subHeadingCroppedImagepath = "".obs;
  final contentCroppedImagepath = "".obs;
  late File imagefile;

  void setPasswordVisible(bool isTrue) {
    isPasswordVisible.value = isTrue;
  }

  void setUserRole(String userRol) {
    singleUserRoleValue.value = userRol;
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
  }

  String? isPasswordValid() {
    if (passwordController.text.trim().isEmpty) {
      return "Please enter password";
    }
    return null;
  }

  String? isFirstNameValid() {
    if (firstNameController.text.trim().isEmpty) {
      return "Please enter name";
    }
    return null;
  }

  String? isLastNameValid() {
    if (lastNameController.text.trim().isEmpty) {
      return "Please enter last name";
    }
    return null;
  }

  String? isEmailValid() {
    if (emailOrPhoneController.text.trim().isEmpty) {
      return "Please enter valid email OR phone number";
    }
    if (!emailOrPhoneController.text.trim().isEmail &&
        !RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
            .hasMatch(emailOrPhoneController.text.trim())) {
      return "Please enter valid email OR phone number";
    }
    return null;
  }

  Future<void> onUpload() async {
    validateFields();
    // emailOrPhoneController.text = "";
    // passwordController.text = "";

    // validateFields();

    // if (isValid()) {
    //   _status.value = RxStatus.loading();
    //   try {
    //     //Perform login logic here
    //     _status.value = RxStatus.success();
    //   } catch (e) {
    //     e.printError();
    //     _status.value = RxStatus.error(e.toString());
    //   }
    // }
  }

  void validateFields() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
    }
  }

  void openImage(ImageSource imageSource, ImageType imageType) async {
    try {
      var pickedFile = await imgpicker.pickImage(source: imageSource);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
        imagefile = File(localImagePath.value);
        cropImage(imageType);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void openCamera(ImageType imageType) async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
        imagefile = File(localImagePath.value);
        cropImage(imageType);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void cropImage(ImageType imageType) async {
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
      headingCroppedImagepath.value = croppedfile.path;
      //setState(() { });
    } else {
      print("Image is not cropped.");
    }
  }
}

enum ImageType { headingImage, subHeadingImage, contentImage }
