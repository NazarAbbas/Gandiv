import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class AboutUsPageController extends GetxController {
  final abourUsData = "".obs;
  final RestAPI restAPI = Get.find<RestAPI>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    executeSignupApi();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> executeSignupApi() async {
    try {
      final aboutUsResponse = await restAPI.calllAboutUsApi();
      abourUsData.value = aboutUsResponse.aboutUsData;
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
