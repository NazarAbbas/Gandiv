import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/values/app_images.dart';
import '../../route_management/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3), () => Get.toNamed(Routes.dashboardScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      width: double.infinity,
      height: double.infinity,
      AppImages.splash,
      fit: BoxFit.cover,
    );
  }
}
