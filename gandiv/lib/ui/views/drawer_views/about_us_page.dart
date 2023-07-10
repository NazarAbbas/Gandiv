import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/about_us_page_controller.dart';
import 'package:gandiv/ui/controllers/e_paper_controller.dart';
import 'package:get/get.dart';

class AboutUsPage extends GetView<AboutUsPageController> {
  const AboutUsPage({Key? key}) : super(key: key);

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
