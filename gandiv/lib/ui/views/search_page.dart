import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

// ignore: must_be_immutable
class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search'.tr),
        backgroundColor: AppColors.colorPrimary,
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // Add padding around the search bar
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // Use a Material design search bar
                child: TextField(
                  focusNode: controller.focusNode.value,
                  onSubmitted: (value) {
                    controller.callSearchApi();
                  },
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: AppColors.colorPrimary, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: AppColors.colorPrimary, width: 1.0),
                    ),
                    hintText: controller.speechTextHint.value,
                    // Add a clear button to the search bar
                    suffixIcon: IconButton(
                        onPressed: () {
                          // controller.isListening.value = false;
                          controller.listen(context);
                        },
                        icon: AvatarGlow(
                          animate: controller.isListening.value,
                          glowColor: AppColors.colorPrimary,
                          endRadius: 90.0,
                          duration: const Duration(microseconds: 2000),
                          repeat: true,
                          repeatPauseDuration:
                              const Duration(microseconds: 1000),
                          child: Icon(
                            controller.isListening.value
                                ? Icons.mic
                                : Icons.mic_none,
                            color: AppColors.colorPrimary,
                          ),
                        )),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: AppColors.colorPrimary,
                      ),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),

                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(
                    //     50.0,
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
