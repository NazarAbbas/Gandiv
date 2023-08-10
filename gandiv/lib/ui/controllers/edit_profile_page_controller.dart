import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/update_profile_request.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/values/app_colors.dart';
import '../../database/app_database.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import '../../models/signup_response.dart';
import '../../models/update_profile_response.dart';
import '../../network/rest_api.dart';

class EditProfilePageController extends GetxController {
  // final isPasswordVisible = true.obs;
  final isLoading = false.obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final AppDatabase appDatabase = Get.find<AppDatabase>();

  final formGlobalKey = GlobalKey<FormState>();

  ImagePicker imgpicker = ImagePicker();
  final localImagePath = "".obs;
  final networkImagePath = "".obs;
  final croppedImagepath = "".obs;
  final mobileNumber = "".obs;
  final email = "".obs;
  late RxBool isLogin = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final profile = await appDatabase.profileDao.findProfile();
    if (profile.isNotEmpty) {
      firstNameController.value.text = profile[0].firstName!;
      lastNameController.value.text = profile[0].lastName!;
      emailController.value.text = profile[0].email!;
      phoneController.value.text = profile[0].mobileNo ?? "";
      //networkImagePath.value = profile[0].profileImage!;
    }
  }

  @override
  void onClose() {
    emailController.value.dispose();
    phoneController.value.dispose();
  }

  String? isValidPhoneNumber() {
    if (phoneController.value.text.trim().length != 10 &&
        phoneController.value.text.trim().isNotEmpty) {
      return "Please enter valid phone number";
    }
    return null;
  }

  String? isFirstNameValid() {
    if (firstNameController.value.text.trim().isEmpty) {
      return "Please enter name";
    }
    return null;
  }

  String? isLastNameValid() {
    if (lastNameController.value.text.trim().isEmpty) {
      return "Please enter last name";
    }
    return null;
  }

  String? isEmailValid() {
    if (emailController.value.text.trim().isEmpty ||
        !emailController.value.text.trim().isEmail) {
      return "Please enter valid email";
    }
    return null;
  }

  void openImage(ImageSource imageSource) async {
    try {
      var pickedFile = await imgpicker.pickImage(source: imageSource);
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
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
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
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
      //imagefile = croppedfile;
      croppedImagepath.value = croppedfile.path;
      //networkImagePath.value = croppedfile.path;

      //setState(() { });
    } else {
      if (kDebugMode) {
        print("Image is not cropped.");
      }
    }
  }

  Future<UpdateProfilleResponse?> executeUpdateProfile() async {
    return await validateFields();
  }

  Future<UpdateProfilleResponse?> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      return await executeUpdateProfileApi();
    }
    return null;
  }

  Future<UpdateProfilleResponse?> executeUpdateProfileApi() async {
    UpdateProfilleResponse? updateProfilleResponse = UpdateProfilleResponse();
    try {
      final profile = await appDatabase.profileDao.findProfile();
      UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
          id: profile[0].id,
          userType: 4.toString(),
          firstName: firstNameController.value.text,
          lastName: lastNameController.value.text,
          email: emailController.value.text,
          file: croppedImagepath.value);
      updateProfilleResponse =
          await restAPI.callUpdateProfileApi(updateProfileRequest);

      // var profileData = ProfileData(
      //     id: signupResponse.signupData?.id,
      //     title: signupResponse.signupData?.title,
      //     firstName: signupResponse.signupData?.firstName,
      //     lastName: signupResponse.signupData?.lastName,
      //     mobileNo: signupResponse.signupData?.mobileNo,
      //     email: signupResponse.signupData?.email,
      //     gender: signupResponse.signupData?.gender,
      //     profileImage: signupResponse.signupData?.profileImage,
      //     role: signupResponse.signupData?.role,
      //     token: signupResponse.signupData?.token);

      // await appDatabase.profileDao.deleteProfile();
      // await appDatabase.profileDao.insertProfile(profileData);
      // await GetStorage()
      //     .write(Constant.token, signupResponse.signupData?.token);

      return updateProfilleResponse;

      // final profile1 =
      //     await appDatabase.profileDao.findProfileById(profileData.id!);
      // final profile = await appDatabase.profileDao.findProfile();
      // final xx = "";
    } on DioException catch (obj) {
      final res = (obj).response;
      // final errorMessage = NetworkExceptions.getDioException(obj);
      updateProfilleResponse = UpdateProfilleResponse();
      updateProfilleResponse.message = res?.data['message'];
      updateProfilleResponse.status = res?.data['status'];
      updateProfilleResponse.signupData = res?.data['data'];
      return updateProfilleResponse;
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Got error : $exception");
      }
    } finally {}
    return null;
  }
}
