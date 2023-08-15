import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);
    tabController.animateTo(0);
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
