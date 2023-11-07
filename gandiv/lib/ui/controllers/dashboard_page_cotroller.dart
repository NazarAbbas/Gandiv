import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../constants/constant.dart';
import '../../constants/enums.dart';
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
  final appName = "".obs;
  final version = "".obs;

  @override
  void onInit() {
    super.onInit();

    final languageId = GetStorage().read(Constant.selectedLanguage);
    if (languageId == Language.english) {
      singleLanguageValue.value = "English";
    } else {
      singleLanguageValue.value = "Hindi";
    }
    findPackageInfo();
  }

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

  void findPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName.value = packageInfo.appName;
    version.value = packageInfo.version;
    //String packageName = packageInfo.packageName;
    //String buildNumber = packageInfo.buildNumber;
  }
}
