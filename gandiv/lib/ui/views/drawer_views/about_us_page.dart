import 'package:cached_network_image/cached_network_image.dart';
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
        centerTitle: true,
        backgroundColor: AppColors.colorPrimary,
        title: Text('about_us'.tr),
      ),
      body: Obx(
        // ignore: sized_box_for_whitespace
        () => controller.isDataLoading.value
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.transparent,
                child: const Center(child: CircularProgressIndicator()),
              )
            : SafeArea(
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
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              height: 200,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              imageUrl:
                                  controller.abourUsData.value.media ?? "",
                              //imageUrl: AppImages.tempURL,
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  width: 40.0,
                                  height: 40.0,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SingleChildScrollView(
                                  child: Text(
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      controller.abourUsData.value.content ??
                                          ""),
                                ),
                              ),
                            ),
                          ],
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
