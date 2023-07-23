import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/login_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/constant.dart';
import '../../network/rest_api.dart';

class LoginPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  void setPasswordVisible(bool isTrue) {
    isPasswordVisible.value = isTrue;
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

  Future<void> onLogin() async {
    // validateFields();
    // emailOrPhoneController.text = "";
    // passwordController.text = "";
    validateFields();

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
      executeSignupApi();
    }
  }

  void executeSignupApi() async {
    try {
      LoginRequest loginRequest = LoginRequest(
          username: emailOrPhoneController.text,
          password: passwordController.text);
      final loginResponse = await restAPI.calllLoginApi(loginRequest);

      final selectedLanguage = GetStorage();
      selectedLanguage.write(Constant.token, loginResponse.loginData.token);
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
