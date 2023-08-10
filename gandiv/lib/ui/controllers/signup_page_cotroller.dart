import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/profile_db_model.dart';
import 'package:gandiv/models/signup_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constant.dart';
import '../../database/app_database.dart';
import '../../models/signup_response.dart';
import '../../network/rest_api.dart';

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

  final formGlobalKey = GlobalKey<FormState>();
  final singleUserRoleValue = "4".obs;

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

  Future<SignupResponse?> onSignup() async {
    return await validateFields();
  }

  Future<SignupResponse?> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      return await executeSignupApi();
    }
    return null;
  }

  Future<SignupResponse?> executeSignupApi() async {
    SignupResponse? signupResponse = SignupResponse();
    try {
      SignupRequest signupRequest = SignupRequest(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
          email: emailController.text,
          mobileNo: phoneNumberController.text,
          password: passwordController.text,
          userType: singleUserRoleValue.value);
      final signupResponse = await restAPI.calllSignupApi(signupRequest);
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

      await appDatabase.profileDao.deleteProfile();
      await appDatabase.profileDao.insertProfile(profileData);
      await GetStorage()
          .write(Constant.token, signupResponse.signupData?.token);

      return signupResponse;

      // final profile1 =
      //     await appDatabase.profileDao.findProfileById(profileData.id!);
      // final profile = await appDatabase.profileDao.findProfile();
      // final xx = "";
    } on DioError catch (obj) {
      final res = (obj).response;
      signupResponse = SignupResponse();
      signupResponse.message = res?.data['message'];
      signupResponse.status = res?.data['status'];
      signupResponse.signupData = res?.data['data'];
      return signupResponse;

      // FOR CUSTOM MESSAGE
      // final errorMessage = NetworkExceptions.getDioException(obj);
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Got error : $exception");
      }
    } finally {}
  }
}
