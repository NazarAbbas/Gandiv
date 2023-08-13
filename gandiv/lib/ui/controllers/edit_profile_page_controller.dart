import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/update_profile_request.dart';
import 'package:gandiv/route_management/routes.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/dialog_utils.dart';
import '../../constants/utils.dart';
import '../../constants/values/app_colors.dart';
import '../../database/app_database.dart';
import 'dart:io';
import 'package:flutter/material.dart';
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
    isLoading.value = true;
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      //final profile = await appDatabase.profileDao.findProfile();
      final profileResponse = await restAPI.callProfileApi();
      firstNameController.value.text = profileResponse.data!.firstName ?? "";
      lastNameController.value.text = profileResponse.data!.lastName ?? "";
      emailController.value.text = profileResponse.data!.email ?? "";
      phoneController.value.text = profileResponse.data!.mobileNo ?? "";
      networkImagePath.value = profileResponse.data?.profileImage ?? "";
    } on DioException catch (obj) {
      final res = (obj).response;
      if (kDebugMode) {
        print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
      }
      if (res?.statusCode == 401) {
        DialogUtils.showSingleButtonCustomDialog(
          context: Get.context!,
          title: 'unauthorized_title'.tr,
          message: 'unauthorized_message'.tr,
          firstButtonText: 'ok'.tr,
          firstBtnFunction: () {
            Navigator.of(Get.context!).pop();
            //Get.toNamed(Routes.loginScreen);
            Navigator.of(Get.context!).pushNamedAndRemoveUntil(
                Routes.loginScreen, (Route<dynamic> route) => false);
          },
        );
      } else {
        DialogUtils.showSingleButtonCustomDialog(
          context: Get.context!,
          title: 'error'.tr,
          message: res != null ? res.statusMessage : 'something_went_wrong'.tr,
          firstButtonText: 'ok'.tr,
          firstBtnFunction: () {
            Navigator.of(Get.context!).pop();
            // Navigator.of(Get.context!).pushNamedAndRemoveUntil(
            //     Routes.loginScreen, (Route<dynamic> route) => false);
          },
        );
      }
      // FOR CUSTOM MESSAGE
      // final errorMessage = NetworkExceptions.getDioException(obj);
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Got error : $exception");
      }
      DialogUtils.showSingleButtonCustomDialog(
        context: Get.context!,
        title: 'error'.tr,
        message: 'something_went_wrong'.tr,
        firstButtonText: 'ok'.tr,
        firstBtnFunction: () {
          Navigator.of(Get.context!).pop();
        },
      );
    } finally {
      isLoading.value = false;
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

  Future<void> executeUpdateProfile() async {
    await validateFields();
  }

  Future<void> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      await executeUpdateProfileApi();
    }
    //Get.back();
    //return null;
  }

  Future<void> executeUpdateProfileApi() async {
    try {
      Utils(Get.context!).startLoading();
      UpdateProfileRequest updateProfileRequest = UpdateProfileRequest();
      updateProfileRequest.firstName = firstNameController.value.text;
      updateProfileRequest.lastName = lastNameController.value.text;
      updateProfileRequest.email = emailController.value.text;
      updateProfileRequest.mobileNo = phoneController.value.text;
      if (croppedImagepath.value.isNotEmpty) {
        updateProfileRequest.file = File(croppedImagepath.value);
      }
      final editProfileResponse =
          await restAPI.callUpdateProfileApi(updateProfileRequest);
      if (editProfileResponse.status == 200) {
        Utils(Get.context!).stopLoading();
      } else {
        Utils(Get.context!).stopLoading();
        DialogUtils.showSingleButtonCustomDialog(
          context: Get.context!,
          title: 'error'.tr,
          message: editProfileResponse.message,
          firstButtonText: 'ok'.tr,
          firstBtnFunction: () {
            Navigator.of(Get.context!).pop();
          },
        );
      }
    } on DioException catch (obj) {
      Utils(Get.context!).stopLoading();
      final res = (obj).response;
      if (res?.statusCode == 401) {
        DialogUtils.showSingleButtonCustomDialog(
          context: Get.context!,
          title: 'unauthorized_title'.tr,
          message: 'unauthorized_message'.tr,
          firstButtonText: 'ok'.tr,
          firstBtnFunction: () {
            Navigator.of(Get.context!).pop();
          },
        );
      } else {
        DialogUtils.showSingleButtonCustomDialog(
          context: Get.context!,
          title: 'error'.tr,
          message: res != null ? res.statusMessage : 'something_went_wrong'.tr,
          firstButtonText: 'ok'.tr,
          firstBtnFunction: () {
            Navigator.of(Get.context!).pop();
          },
        );
      }
      //return updateProfilleResponse;
    } on Exception catch (exception) {
      Utils(Get.context!).stopLoading();
      if (kDebugMode) {
        print("Got error : $exception");
      }
      try {
        DialogUtils.showSingleButtonCustomDialog(
          context: Get.context!,
          title: 'error'.tr,
          message: 'something_went_wrong'.tr,
          firstButtonText: 'ok'.tr,
          firstBtnFunction: () {
            Navigator.of(Get.context!).pop();
          },
        );
      } on Exception catch (exception) {
        final message = exception.toString();
      }
    } finally {}
  }
}
