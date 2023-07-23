import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constant.dart';
import '../../database/app_database.dart';
import '../../network/rest_api.dart';
import '../../route_management/routes.dart';

class SplashPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();

  @override
  void onInit() {
    super.onInit();
    final selectedLanguage = GetStorage();
    selectedLanguage.write(Constant.selectedLanguage, 1);
    selectedLanguage.write(Constant.token,
        "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3ODExYjg2Ny0zYzQ4LTRkZjYtMzY3My0wOGRiNzE3OWU0YzIiLCJlbWFpbCI6ImFkbWluQGdhbmRpdi5jb20iLCJhdWQiOlsiU3VwZXJBZG1pbiIsIkF1ZGllbmNlIl0sInJvbGUiOiJTdXBlckFkbWluIiwibmJmIjoxNjkwMTEyMjE5LCJleHAiOjE2OTAxMTU4MTksImlhdCI6MTY5MDExMjIxOSwiaXNzIjoiSXNzdWVyIn0.CFvO1iI-kyhRx3ptCc61tMG50lG8EN34PHmSlSCSXbUqhQPkSpZpx117Ny867PF_1AWd5ie8PwxjwS0_H4Sv0g");
    final token = GetStorage().read(Constant.token);
    getLocationsApis();
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
