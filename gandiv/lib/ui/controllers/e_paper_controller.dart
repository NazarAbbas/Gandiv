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
        final response = await restAPI.calllEPaperApi();
        if (response.status == 200 || response.status == 201) {
          pdfUrl.value = response.ePaperData;
        } else {
          DialogUtils.errorAlert(
            context: Get.context!,
            title: 'error'.tr,
            message: response.message,
            btnText: 'ok'.tr,
            callBackFunction: () {
              Navigator.of(Get.context!).pop();
            },
          );
        }
      } else {
        DialogUtils.noInternetConnection(
          context: Get.context!,
          callBackFunction: () {},
        );
      }
    } on DioException catch (obj) {
      final res = (obj).response;
      if (res?.statusCode == 401) {
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'unauthorized_title'.tr,
          message: 'unauthorized_message'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            // Navigator.of(Get.context!).pop();
          },
        );
      } else {
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message:
              res != null ? res.data['message'] : 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            //Navigator.of(Get.context!).pop();
          },
        );
      }
      //return updateProfilleResponse;
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Got error : $exception");
      }
      try {
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message: 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            //Navigator.of(Get.context!).pop();
          },
        );
      } on Exception catch (exception) {
        final message = exception.toString();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } finally {}
  }
}
