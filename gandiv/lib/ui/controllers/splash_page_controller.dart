import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gandiv/constants/utils.dart';
import 'package:gandiv/ui/controllers/comman_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constant.dart';
import '../../constants/dialog_utils.dart';
import '../../database/app_database.dart';
import '../../network/rest_api.dart';
import '../../route_management/routes.dart';

class SplashPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  CommanController commanController = Get.find<CommanController>();

  @override
  void onInit() async {
    super.onInit();
    final selectedLanguage = GetStorage();
    selectedLanguage.write(Constant.selectedLanguage, 1);
    final profileData = await appDatabase.profileDao.findProfile();
    if (profileData.isNotEmpty) {
      commanController.isNotLogedIn.value = false;
      commanController.userRole.value = profileData[0].role!;
    } else {
      commanController.isNotLogedIn.value = true;
    }

    await getLocationsApis();
  }

  Future<void> getLocationsApis() async {
    try {
      if (await Utils.checkUserConnection()) {
        final response = await restAPI.calllNewsLocations();
        await appDatabase.locationsDao.deleteLocations();
        // ignore: avoid_function_literals_in_foreach_calls
        response.data.forEach((element) async {
          await appDatabase.locationsDao.insertLocations(element);
        });
        getCategoriesApis();
      } else {
        DialogUtils.noInternetConnection(
          context: Get.context!,
          callBackFunction: () {
            exit(0);
          },
        );
      }
    } on DioException catch (obj) {
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
    } on SocketException catch (e) {
      if (kDebugMode) {
        print("Got error ");
      }
    } on Exception catch (exception) {
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

  Future<void> getCategoriesApis() async {
    try {
      if (await Utils.checkUserConnection()) {
        final response = await restAPI.calllNewsCategories();
        await appDatabase.categoriesDao.deleteCategories();
        response.data.forEach((element) async {
          await appDatabase.categoriesDao.insertCategories(element);
        });
      } else {
        DialogUtils.noInternetConnection(
          context: Get.context!,
          callBackFunction: () {
            //Navigator.of(Get.context!).pop();
          },
        );
      }
    } on DioException catch (obj) {
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
    } finally {
      Timer(const Duration(seconds: 1),
          () => Get.offNamed(Routes.dashboardScreen));
      // Get.toNamed(Routes.dashboardScreen);
    }
  }
}
