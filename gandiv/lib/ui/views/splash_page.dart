import 'package:flutter/material.dart';
import 'package:gandiv/ui/controllers/splash_page_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constant.dart';
import '../../constants/values/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String dropdownvalue = 'Please select location';
  @override
  void initState() {
    super.initState();
    GetStorage().write(Constant.selectedLanguage, 1);
    GetStorage().write(Constant.selectedLocation, 'Varanasi');
    Get.find<SplashPageController>();
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
