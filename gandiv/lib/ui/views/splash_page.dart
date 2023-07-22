import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gandiv/ui/controllers/splash_page_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import '../../constants/constant.dart';
import '../../constants/values/app_images.dart';
import '../../route_management/routes.dart';

// class SplashPage extends GetView<SplashPageController> {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       width: double.infinity,
//       height: double.infinity,
//       AppImages.splash,
//       fit: BoxFit.cover,
//     );
//   }
// }

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // var items = [
  //   'Please select location',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];
  // String dropdownvalue = 'Please select location';
  @override
  void initState() {
    super.initState();
    final selectedLanguage = GetStorage();
    selectedLanguage.write(Constant.selectedLanguage, 1);
    SplashPageController splashPageController =
        Get.find<SplashPageController>();
    //splashPageController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Container(
    //           width: double.infinity,
    //           child: DropdownButtonHideUnderline(
    //             child: GFDropdown(
    //               hint: const Text('Please select location'),
    //               padding: const EdgeInsets.all(0),
    //               borderRadius: BorderRadius.circular(5),
    //               border: const BorderSide(color: Colors.black12, width: 1),
    //               dropdownButtonColor: Colors.white,
    //               value: dropdownvalue,
    //               onChanged: (newValue) {
    //                 setState(() {
    //                   dropdownvalue = newValue!;
    //                 });
    //               },
    //               items: [
    //                 'Please select location',
    //                 'FC Barcelona',
    //                 'Real Madrid',
    //                 'Villareal',
    //                 'Manchester City'
    //               ]
    //                   .map((value) => DropdownMenuItem(
    //                         value: value,
    //                         child: Text(value),
    //                       ))
    //                   .toList(),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    return Image.asset(
      width: double.infinity,
      height: double.infinity,
      AppImages.splash,
      fit: BoxFit.cover,
    );
  }
}
