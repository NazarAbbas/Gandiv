import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/login_request.dart';
import 'package:gandiv/models/login_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/constant.dart';
import '../../database/app_database.dart';
import '../../models/profile_db_model.dart';
import '../../network/rest_api.dart';

class LoginPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final isPasswordVisible = true.obs;
  final isLoading = false.obs;
  final AppDatabase appDatabase = Get.find<AppDatabase>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  void setPasswordVisible(bool isTrue) {
    isPasswordVisible.value = isTrue;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }

  String? isPasswordValid() {
    if (passwordController.text.trim().isEmpty) {
      return "Please enter password";
    }
    return null;
  }

  String? isValidEmail() {
    if (emailController.text.trim().isEmpty ||
        !emailController.text.trim().isEmail) {
      return "Please enter valid email";
    }
    return null;
    // final bool emailValid = RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(emailController.text);
  }

  // String? isEmailValid() {
  //   if (emailOrPhoneController.text.trim().isEmpty) {
  //     return "Please enter valid email OR phone number";
  //   }
  //   if (!emailOrPhoneController.text.trim().isEmail &&
  //       !RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
  //           .hasMatch(emailOrPhoneController.text.trim())) {
  //     return "Please enter valid email OR phone number";
  //   }
  //   return null;
  // }

  Future<LoginResponse?> onLogin() async {
    return await validateFields();
  }

  Future<LoginResponse?> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      return await executeLoginApi();
    }
    return null;
  }

  Future<LoginResponse?> executeLoginApi() async {
    LoginResponse? loginResponse = LoginResponse();
    try {
      LoginRequest loginRequest = LoginRequest(
          username: emailController.text, password: passwordController.text);
      loginResponse = await restAPI.calllLoginApi(loginRequest);
      GetStorage().write(Constant.token, loginResponse.loginData?.token);
      var profileData = ProfileData(
          id: loginResponse.loginData?.id,
          title: loginResponse.loginData?.title,
          firstName: loginResponse.loginData?.firstName,
          lastName: loginResponse.loginData?.lastName,
          mobileNo: loginResponse.loginData?.mobileNo,
          email: loginResponse.loginData?.email,
          gender: loginResponse.loginData?.gender,
          profileImage: loginResponse.loginData?.profileImage,
          role: loginResponse.loginData?.role,
          token: loginResponse.loginData?.token);
      await appDatabase.profileDao.deleteProfile();
      await appDatabase.profileDao.insertProfile(profileData);
      await GetStorage().write(Constant.token, loginResponse.loginData?.token);
      return loginResponse;
    } on DioError catch (obj) {
      final res = (obj).response;
      loginResponse ??= LoginResponse();
      loginResponse.message = res?.data['message'];
      loginResponse.status = res?.data['status'];
      loginResponse.loginData = res?.data['data'];
      return loginResponse;
      // FOR CUSTOM MESSAGE
      // final errorMessage = NetworkExceptions.getDioException(obj);
    } on Exception catch (exception) {
      return loginResponse;
    } finally {}
  }
}
