import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/values/app_colors.dart';
import '../controllers/dashboard_page_cotroller.dart';
import '../controllers/notification_page_controller.dart';

class NotificationPage extends GetView<NotificationPageController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardPageController dashboardPageController =
        Get.find<DashboardPageController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.colorPrimary,
        title: Text('notificatios'.tr),
      ),
      body: Container(
          alignment: Alignment.center, child: const Text("Notification Page")),
    );
  }
}
