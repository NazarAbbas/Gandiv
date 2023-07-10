import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

    // final database = Get.find<AppDatabase>();
    // final userDao = database.userDao;
    // final user = Users(id: 4, login: 'demo@gmail.com');
    // await userDao.insertUser(user);
    // final delete = await userDao.deleteUserById(1);
    // final search = await userDao.findAllUsers();
    // final allUsers = await userDao.findAllUsers();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
