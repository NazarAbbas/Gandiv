import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/values/app_colors.dart';
import '../controllers/notification_page_controller.dart';

class NotificationPage extends GetView<NotificationPageController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: Text('notificatios'.tr),
      ),
      body: Container(
          alignment: Alignment.center, child: const Text("Notification Page")),
    );
  }
}
