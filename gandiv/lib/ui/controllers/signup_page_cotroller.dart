import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/signup_request.dart';
import 'package:gandiv/models/signup_response.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class SignupPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();

  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  final singleUserRoleValue = "Reporter".obs;

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

  String? isEmailValid() {
    if (emailController.text.trim().isEmpty) {
      return "Please enter valid email OR phone number";
    }
    if (!emailController.text.trim().isEmail &&
        !RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
            .hasMatch(emailController.text.trim())) {
      return "Please enter valid email OR phone number";
    }
    return null;
  }

  String? isValidPhoneNumber() {
    if (phoneNumberController.text.trim().length != 10) {
      return "Please enter valid phone number";
    }
    return null;
  }

  Future<void> onSignup() async {
    await validateFields();
    // emailOrPhoneController.text = "";
    // passwordController.text = "";
    // validateFields();
  }

  Future<void> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      await executeSignupApi();
    }
  }

  Future<void> executeSignupApi() async {
    try {
      SignupRequest signupRequest = SignupRequest(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          userType: 4);
      final signupResponse = await restAPI.calllSignupApi(signupRequest);
    } on DioError catch (obj) {
      final res = (obj).response;
      if (kDebugMode) {
        print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
      }
      // FOR CUSTOM MESSAGE
      // final errorMessage = NetworkExceptions.getDioException(obj);
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Got error : $exception");
      }
    } finally {}
  }
}
