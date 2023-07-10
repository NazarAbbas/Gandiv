import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfilePageController extends GetxController {
  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailOrPhoneController = TextEditingController();
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

  Future<void> onSignup() async {
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
}
