import 'package:get/get.dart';
import '../../network/rest_api.dart';

class DashboardPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
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
}
