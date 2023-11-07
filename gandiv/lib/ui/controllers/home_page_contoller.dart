import 'package:flutter/material.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/constant.dart';
import '../../database/app_database.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  List<Categories> catgories = <Categories>[].obs;
  var isDataLoading = false.obs;
  var tabsLength = 1.obs;
  var languageId;
  @override
  void onInit() async {
    super.onInit();
    isDataLoading.value = true;
    catgories.clear();
    languageId = GetStorage().read(Constant.selectedLanguage);
    catgories = await appDatabase.categoriesDao.findCategories();
    Categories categoryHome = Categories(
        id: "", name: "Home", hindiName: "होम", isActive: true, catOrder: 0);
    catgories.insert(0, categoryHome);
    tabsLength.value = catgories.length;

    tabController = TabController(
      vsync: this,
      length: catgories.length,
    );
    isDataLoading.value = false;
    tabController.animateTo(0,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
