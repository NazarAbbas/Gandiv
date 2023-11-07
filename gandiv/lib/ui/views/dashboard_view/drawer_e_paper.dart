import 'package:flutter/material.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:get/get.dart';

import '../../../constants/values/app_colors.dart';
import '../../../constants/values/size_config.dart';
import '../../../route_management/routes.dart';

class DrawerEPaper extends GetView<DashboardPageController> {
  const DrawerEPaper({super.key, required this.context});
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return ePaperColumn();
  }

  Obx ePaperColumn() {
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.ePaperPage);
            },
            child: Container(
              width: double.infinity,
              color: controller.isDarkTheme.value == true
                  ? AppColors.dartTheme
                  : AppColors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    textAlign: TextAlign.left,
                    'e_paper'.tr,
                    style: TextStyle(
                      color: controller.isDarkTheme.value == true
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.navigationDrawerHeadingFontSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Divider(
          //   color: controller.isDarkTheme.value == true
          //       ? AppColors.white
          //       : AppColors.black,
          // ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: .5,
            color: controller.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.black,
          ),
        ],
      ),
    );
  }
}
