import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gandiv/models/profile_db_model.dart';
import 'package:gandiv/models/signup_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constant.dart';
import '../../constants/dialog_utils.dart';
import '../../constants/utils.dart';
import '../../database/app_database.dart';
import '../../network/rest_api.dart';
import 'comman_controller.dart';

class SignupPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();

  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  CommanController commanController = Get.find<CommanController>();

  final formGlobalKey = GlobalKey<FormState>();
  final singleUserRoleValue = "3".obs;

  void setPasswordVisible(bool isTrue) {
    isPasswordVisible.value = isTrue;
  }

  void setUserRole(String userRol) {
    singleUserRoleValue.value = userRol;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
  }

  String? isPasswordValid() {
    if (passwordController.text.trim().isEmpty) {
      return 'enter_password'.tr;
    }
    return null;
  }

  String? isFirstNameValid() {
    if (firstNameController.text.trim().isEmpty) {
      return 'enter_first_name'.tr;
    }
    return null;
  }

  String? isLastNameValid() {
    if (lastNameController.text.trim().isEmpty) {
      return 'enter_last_name'.tr;
    }
    return null;
  }

  String? isValidEmail() {
    if (emailController.text.trim().isEmpty ||
        !emailController.text.trim().isEmail) {
      return "Please enter valid email";
    }
    return null;
  }

  String? isValidPhoneNumber() {
    if (phoneNumberController.text.trim().length != 10 &&
        phoneNumberController.text.trim().isNotEmpty) {
      return "Please enter valid phone number";
    }
    return null;
  }

  Future<void> onSignup() async {
    await validateFields();
  }

  Future<void> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      await executeSignupApi();
    }
  }

  Future<void> executeSignupApi() async {
    try {
      if (await Utils.checkUserConnection()) {
        Utils(Get.context!).startLoading();
        SignupRequest signupRequest = SignupRequest(
            firstname: firstNameController.text,
            lastname: lastNameController.text,
            email: emailController.text,
            mobileNo: phoneNumberController.text,
            password: passwordController.text,
            userType: singleUserRoleValue.value);
        final signupResponse = await restAPI.calllSignupApi(signupRequest);
        if (signupResponse.status == 200) {
          var profileData = ProfileData(
              id: signupResponse.signupData?.id,
              title: signupResponse.signupData?.title,
              firstName: signupResponse.signupData?.firstName,
              lastName: signupResponse.signupData?.lastName,
              mobileNo: signupResponse.signupData?.mobileNo,
              email: signupResponse.signupData?.email,
              gender: signupResponse.signupData?.gender,
              profileImage: signupResponse.signupData?.profileImage,
              role: signupResponse.signupData?.role,
              token: signupResponse.signupData?.token);
          commanController.isNotLogedIn.value = false;
          commanController.userRole.value = signupResponse.signupData!.role!;
          await appDatabase.profileDao.deleteProfile();
          await appDatabase.profileDao.insertProfile(profileData);
          await GetStorage()
              .write(Constant.token, signupResponse.signupData?.token);
          Utils(Get.context!).stopLoading();

          DialogUtils.showSingleButtonCustomDialog(
            context: Get.context!,
            title: 'success'.tr,
            message: 'registration_success_alert'.tr,
            firstButtonText: 'ok'.tr,
            firstBtnFunction: () {
              Navigator.of(Get.context!).pop();
              Get.back();
              Get.back();
            },
          );
        } else {
          Utils(Get.context!).stopLoading();
          DialogUtils.showSingleButtonCustomDialog(
            context: Get.context!,
            title: 'error'.tr,
            message: signupResponse.message,
            firstButtonText: 'ok'.tr,
            firstBtnFunction: () {
              Navigator.of(Get.context!).pop();
            },
          );
        }
      } else {
        Utils(Get.context!).stopLoading();
        DialogUtils.noInternetConnection(
          context: Get.context!,
          callBackFunction: () {},
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
