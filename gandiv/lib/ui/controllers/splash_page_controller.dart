import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/ui/controllers/comman_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constant.dart';
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
      final response = await restAPI.calllNewsLocations();
      await appDatabase.locationsDao.deleteLocations();
      response.data.forEach((element) async {
        await appDatabase.locationsDao.insertLocations(element);
      });
      // final xx = await appDatabase.locationsDao.findLocations();
      // final xxxx = xx;
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
    } finally {
      getCategoriesApis();
      //isDataLoading.value = false;
    }
  }

  Future<void> getCategoriesApis() async {
    try {
      final response = await restAPI.calllNewsCategories();
      await appDatabase.categoriesDao.deleteCategories();
      response.data.forEach((element) async {
        await appDatabase.categoriesDao.insertCategories(element);
      });
      // final xx = await appDatabase.categoriesDao.findCategories();
      // final xxxx = xx;
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
    } finally {
      Timer(const Duration(seconds: 2),
          () => Get.toNamed(Routes.dashboardScreen));
      // Get.toNamed(Routes.dashboardScreen);
    }
  }
}
