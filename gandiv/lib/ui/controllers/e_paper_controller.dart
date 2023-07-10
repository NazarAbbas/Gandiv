import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../constants/utils.dart';
import '../../network/rest_api.dart';

class EPaperController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final pdfUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    executeEPaperApi();
    // pdfUrl.value = 'https://www.fluttercampus.com/sample.pdf';
    //https://drive.google.com/file/d/1Ru91EuHeoadRbvIalPcrgHgEplmbEh4l/view?pli=1
  }

  @override
  void onReady() {
    super.onReady();
    // executeEPaperApi();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> executeEPaperApi() async {
    try {
      final aboutUsResponse = await restAPI.calllEPaperApi();
      pdfUrl.value = aboutUsResponse.ePaperData;
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
