import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/about_us_response.dart';
import 'package:get/get.dart';

import '../../constants/dialog_utils.dart';
import '../../constants/utils.dart';
import '../../network/rest_api.dart';

class AboutUsPageController extends GetxController {
  final abourUsData = AboutusData().obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  var isDataLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isDataLoading.value = true;
    await executeSignupApi();
    isDataLoading.value = false;
  }

  Future<void> executeSignupApi() async {
    try {
      // Utils(Get.context!).startLoading();
      if (await Utils.checkUserConnection()) {
        final aboutUsResponse = await restAPI.calllAboutUsApi();
        if (aboutUsResponse.status == 200 || aboutUsResponse.status == 201) {
          abourUsData.value = aboutUsResponse.aboutUsData;
        } else {
          DialogUtils.errorAlert(
            context: Get.context!,
            title: 'error'.tr,
            message: aboutUsResponse.message,
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
