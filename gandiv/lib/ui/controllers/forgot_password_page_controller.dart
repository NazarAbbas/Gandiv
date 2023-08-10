import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/forgot_password_response.dart';
import '../../network/rest_api.dart';

class ForgotPasswordPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final isPasswordVisible = true.obs;
  final isLoading = false.obs;
  final emailController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  void setPasswordVisible(bool isTrue) {
    isPasswordVisible.value = isTrue;
  }

  @override
  void onClose() {
    emailController.dispose();
  }

  String? isValidEmail() {
    if (emailController.text.trim().isEmpty ||
        !emailController.text.trim().isEmail) {
      return 'please_enter_valid_email'.tr;
    }
    return null;
  }

  Future<ForgotPasswordResponse?> onForgotPassword() async {
    return await validateFields();
  }

  Future<ForgotPasswordResponse?> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      return await executeForgotPasswordApi();
    }
    return null;
  }

  Future<ForgotPasswordResponse?> executeForgotPasswordApi() async {
    // ForgotPasswordResponse? loginResponse = ForgotPasswordResponse();
    ForgotPasswordResponse? forgotPasswordResponse = null;
    try {
      forgotPasswordResponse = (await restAPI.callForgotPassswordApi(
          userName: emailController.text));
      return forgotPasswordResponse;
    } on DioException catch (obj) {
      final res = (obj).response;
      return forgotPasswordResponse;
      // FOR CUSTOM MESSAGE
      // final errorMessage = NetworkExceptions.getDioException(obj);
    } on Exception catch (exception) {
      //return loginResponse;
    } finally {
      // ignore: control_flow_in_finally
      return forgotPasswordResponse;
    }
  }
}
