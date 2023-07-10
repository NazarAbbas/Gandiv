import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/values/app_colors.dart';

class ProfilePageController extends GetxController {
  ImagePicker imgpicker = ImagePicker();
  final localImagePath = "".obs;
  final networkImagePath = "".obs;
  final croppedImagepath = "".obs;
  late File imagefile;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    networkImagePath.value = 'https://googleflutter.com/sample_image.jpg';
  }

  @override
  void onClose() {
    super.onClose();
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
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
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
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
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
      print("Image is not cropped.");
    }
  }
}
