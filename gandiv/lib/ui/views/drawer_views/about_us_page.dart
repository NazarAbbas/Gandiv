import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/about_us_page_controller.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_page_cotroller.dart';

// ignore: must_be_immutable
class AboutUsPage extends GetView<AboutUsPageController> {
  AboutUsPage({Key? key}) : super(key: key);
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: Text('about_us'.tr),
      ),
      body: Obx(
        // ignore: sized_box_for_whitespace
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 3,
              shadowColor: Colors.black,
              color: AppColors.white,
              child: Container(
                color: AppColors.lightGray,
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Text(
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        controller.abourUsData.value),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
