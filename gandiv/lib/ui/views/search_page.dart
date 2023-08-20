import 'package:avatar_glow/avatar_glow.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import '../../constants/dialog_utils.dart';
import '../../constants/utils.dart';
import '../../constants/values/app_images.dart';
import '../../database/app_database.dart';
import '../../route_management/routes.dart';
import '../controllers/dashboard_page_cotroller.dart';
import '../controllers/search_page_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  //int selectedPosition = 0;
  // Widget build(BuildContext context) {
  // //   return SafeArea(
  // //     child: Scaffold(
  // //       body: HomeNewsPageListRow(),
  // //       // body: Obx(
  // //       //   () => controller.isDataLoading.value || controller.newsList.isEmpty
  // //       //       ? Container(
  // //       //           width: double.infinity,
  // //       //           height: double.infinity,
  // //       //           color: AppColors.transparent,
  // //       //           child: const Center(child: CircularProgressIndicator()))
  // //       //       : HomeNewsPageListRow(),
  // //       // ),
  // //     ),
  // //   );
  // // }

  @override
  SearchPagePageListRow createState() => SearchPagePageListRow();
}

class SearchPagePageListRow extends State<SearchPage> {
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();
  SearchPageController controller = Get.find<SearchPageController>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  int selectedPosition = 0;

  // Future<void> _pullRefresh() async {
  //   controller.pageNo = 1;
  //   controller.pageSize = 5;
  //   controller.newsList.clear();
  //   controller.onInit();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search'.tr),
        backgroundColor: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.colorPrimary,
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
                  textInputAction: TextInputAction.search,
                  onChanged: (content) {
                    if (controller.searchController.text.isEmpty) {
                      setState(() {});
                    }
                  },
                  onSubmitted: (value) {
                    if (controller.searchController.text.isNotEmpty) {
                      controller.newsList.clear();
                      controller.callSearchApi();
                    } else {
                      DialogUtils.showSingleButtonCustomDialog(
                        context: context,
                        title: 'search'.tr,
                        message: 'please_enter_valid_search_key'.tr,
                        firstButtonText: 'OK',
                        firstBtnFunction: () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color:
                              dashboardPageController.isDarkTheme.value == true
                                  ? AppColors.white
                                  : AppColors.colorPrimary,
                          width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color:
                              dashboardPageController.isDarkTheme.value == true
                                  ? AppColors.white
                                  : AppColors.colorPrimary,
                          width: 1.0),
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
                          glowColor:
                              dashboardPageController.isDarkTheme.value == true
                                  ? AppColors.white
                                  : AppColors.colorPrimary,
                          endRadius: 90.0,
                          duration: const Duration(microseconds: 2000),
                          repeat: true,
                          repeatPauseDuration:
                              const Duration(microseconds: 1000),
                          child: Icon(
                            controller.isListening.value
                                ? Icons.mic
                                : Icons.mic_none,
                            color: dashboardPageController.isDarkTheme.value ==
                                    true
                                ? AppColors.white
                                : AppColors.colorPrimary,
                          ),
                        )),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: dashboardPageController.isDarkTheme.value == true
                            ? AppColors.white
                            : AppColors.colorPrimary,
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
            Expanded(
              child: (controller.newsList.isEmpty &&
                      controller.searchController.text.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.lightGray,
                        child: Center(
                          child: Text('no_news_available'.tr,
                              style: TextStyle(
                                  color: dashboardPageController
                                              .isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : AppColors.colorPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      ),
                    )
                  : controller.searchController.text.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: dashboardPageController.isDarkTheme.value ==
                                    true
                                ? AppColors.dartTheme
                                : AppColors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'search_messgae'.tr,
                                    style: TextStyle(
                                        color: dashboardPageController
                                                    .isDarkTheme.value ==
                                                true
                                            ? AppColors.white
                                            : AppColors.colorPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          key: const PageStorageKey('home_news_page'),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.newsList.length,
                          controller: controller.controller,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => {
                                Utils(context).stopAudio(controller
                                            .newsList[selectedPosition]
                                            .newsContent ==
                                        null
                                    ? ""
                                    : controller.newsList[selectedPosition]
                                        .newsContent!),
                                controller.setAudioPlaying(
                                    false, selectedPosition),
                                Get.toNamed(Routes.newsDetailPage,
                                        arguments: controller.newsList[index])
                                    ?.then(
                                  (value) => {controller.onInit()},
                                )
                              },
                              child: rowWidget(index, context),
                            );
                          },
                        ),
            ),
            if (controller.isLoadMoreItems.value == true)
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Center(
                  child: Column(
                    children: [
                      Text('loading'.tr,
                          style: TextStyle(
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Card rowWidget(int index, BuildContext context) {
    return Card(
      color: dashboardPageController.isDarkTheme.value == true
          ? AppColors.dartTheme
          : AppColors.white,
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Visibility(
              visible:
                  controller.newsList[index].heading == null ? false : true,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.newsList[index].heading == null
                      ? ""
                      : controller.newsList[index].heading!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Visibility(
              visible:
                  controller.newsList[index].newsContent == null ? false : true,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.newsList[index].newsContent == null
                      ? ""
                      : controller.newsList[index].newsContent!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: dashboardPageController.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: controller.newsList[index].mediaList?.imageList == null
                ? false
                : true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarouselSlider(
                options: CarouselOptions(
                    pauseAutoPlayOnTouch: true,
                    autoPlay: false,
                    height: MediaQuery.of(context).size.width * (3 / 4),
                    enlargeCenterPage: true),
                items:
                    controller.newsList[index].mediaList?.imageList?.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        fit: BoxFit.cover,
                        i.url!,
                        width: MediaQuery.of(context).size.width,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Center(
                  child: Image.asset(
                    color: dashboardPageController.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.black,
                    AppImages.clock,
                    height: 25,
                    width: 25,
                  ),
                ),
                Center(
                  child: Text(
                    controller.newsList[index].durationInMin == null
                        ? "0 ${'in_minutes'.tr}"
                        : "${controller.newsList[index].durationInMin!} ${'in_minutes'.tr}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: dashboardPageController.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    final newsContent =
                        controller.newsList[index].newsContent == null
                            ? ""
                            : controller.newsList[index].newsContent!;
                    if (newsContent.isEmpty) {
                      return;
                    }
                    if (controller.newsList[index].isAudioPlaying == true) {
                      Utils(context).stopAudio(newsContent);
                      controller.setAudioPlaying(false, index);
                    } else {
                      Utils(context).stopAudio(newsContent);
                      controller.setAudioPlaying(false, selectedPosition);
                      selectedPosition = index;
                      Utils(context).startAudio(newsContent);
                      controller.setAudioPlaying(true, index);
                    }
                  },
                  child: Image.asset(
                    color: dashboardPageController.isDarkTheme.value == true
                        ? controller.newsList[index].isAudioPlaying == true
                            ? AppColors.colorPrimary
                            : AppColors.white
                        : controller.newsList[index].isAudioPlaying == true
                            ? AppColors.colorPrimary
                            : AppColors.black,
                    AppImages.audio,
                    width: 30,
                    height: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () async {
                      if (controller.newsList[index].isBookmark == true) {
                        controller.removeBookmark(index);
                      } else {
                        controller.setBookmark(index);
                      }
                    },
                    child: Image.asset(
                      color: dashboardPageController.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.colorPrimary,
                      controller.newsList[index].isBookmark == true
                          ? AppImages.highLightBookmark
                          : AppImages.bookmark,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      Utils.share(controller.newsList[index]);
                    },
                    child: Image.asset(
                      color: dashboardPageController.isDarkTheme.value == true
                          ? AppColors.white
                          : AppColors.black,
                      AppImages.share,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// ignore: must_be_immutable
// class SearchPage extends GetView<SearchPageController> {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('search'.tr),
//         backgroundColor: AppColors.colorPrimary,
//       ),
//       body: Obx(
//         () => Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 // Add padding around the search bar
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 // Use a Material design search bar
//                 child: TextField(
//                   focusNode: controller.focusNode.value,
//                   textInputAction: TextInputAction.search,
//                   onSubmitted: (value) {
//                     controller.callSearchApi();
//                   },
//                   controller: controller.searchController,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide:
//                           BorderSide(color: AppColors.colorPrimary, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide:
//                           BorderSide(color: AppColors.colorPrimary, width: 1.0),
//                     ),
//                     hintText: controller.speechTextHint.value,
//                     // Add a clear button to the search bar
//                     suffixIcon: IconButton(
//                         onPressed: () {
//                           // controller.isListening.value = false;
//                           controller.listen(context);
//                         },
//                         icon: AvatarGlow(
//                           animate: controller.isListening.value,
//                           glowColor: AppColors.colorPrimary,
//                           endRadius: 90.0,
//                           duration: const Duration(microseconds: 2000),
//                           repeat: true,
//                           repeatPauseDuration:
//                               const Duration(microseconds: 1000),
//                           child: Icon(
//                             controller.isListening.value
//                                 ? Icons.mic
//                                 : Icons.mic_none,
//                             color: AppColors.colorPrimary,
//                           ),
//                         )),
//                     // Add a search icon or button to the search bar
//                     prefixIcon: IconButton(
//                       icon: Icon(
//                         Icons.search,
//                         color: AppColors.colorPrimary,
//                       ),
//                       onPressed: () {
//                         // Perform the search here
//                       },
//                     ),

//                     // border: OutlineInputBorder(
//                     //   borderRadius: BorderRadius.circular(
//                     //     50.0,
//                     //   ),
//                     // ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
