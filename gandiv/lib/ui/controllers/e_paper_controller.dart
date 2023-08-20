import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../constants/dialog_utils.dart';
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
      if (await Utils.checkUserConnection()) {
        final aboutUsResponse = await restAPI.calllEPaperApi();
        pdfUrl.value = aboutUsResponse.ePaperData;
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
          message:
              res != null ? res.data['message'] : 'something_went_wrong'.tr,
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
