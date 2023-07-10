import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../models/dashboard_screen_model.dart';
import '../../network/rest_api.dart';

class DashboardPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  //List<Users> usersList = <Users>[].obs;
  final count = 0.obs;
  RxBool isLangVisible = false.obs;
  RxBool isDarkTheme = false.obs;
  RxBool isLocVisible = false.obs;
  final singleLanguageValue = "Hindi".obs;
  final singleLocationValue = "Varansi".obs;
  RxInt bottomTabbarIndex = 0.obs;

  void increment() {
    count.value++;
  }

  void setTabbarIndex(int tabbarIndex) {
    bottomTabbarIndex.value = tabbarIndex;
  }

  void selectLanguage(String value) {
    singleLanguageValue.value = value;
  }

  void setTheme(bool value) {
    isDarkTheme.value = value;
  }

  void selectLocation(String value) {
    singleLocationValue.value = value;
  }

  void isLanguageVisible() {
    if (isLangVisible.value) {
      isLangVisible.value = false;
    } else {
      isLangVisible.value = true;
    }
  }

  void isLocationVisible() {
    if (isLocVisible.value) {
      isLocVisible.value = false;
    } else {
      isLocVisible.value = true;
    }
  }

  // void getDashboardData() async {
  //   try {
  //     final response = await restAPI.getDataMethod();
  //     usersList.assignAll(response);
  //   } on DioError catch (obj) {
  //     final res = (obj).response;
  //     if (kDebugMode) {
  //       print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
  //     }
  //     // FOR CUSTOM MESSAGE
  //     // final errorMessage = NetworkExceptions.getDioException(obj);
  //   } on Exception catch (exception) {
  //     if (kDebugMode) {
  //       print("Got error : $exception");
  //     }
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
// List<Users> createUserList(List data) {
//   List<Users> list = [];
//   for (int i = 0; i < data.length; i++) {
//     Users user = Users.fromJson(data[i]);
//     list.add(user);
//   }
//   return list;
// }
