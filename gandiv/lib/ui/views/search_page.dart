import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/constants/values/size_config.dart';
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
                height: 50,
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
                      DialogUtils.errorAlert(
                        context: context,
                        title: 'search'.tr,
                        message: 'please_enter_valid_search_key'.tr,
                        btnText: 'OK',
                        callBackFunction: () {
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
                                Utils(context).stopAudio(),
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
                              color:
                                  dashboardPageController.isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.loadMoreSize)),
                      CircularProgressIndicator(
                        color: dashboardPageController.isDarkTheme.value == true
                            ? AppColors.white
                            : AppColors.black,
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

  Container rowWidget(int index, BuildContext context) {
    return Container(
      color: dashboardPageController.isDarkTheme.value == true
          ? AppColors.white
          : AppColors.dartTheme,
      child: Card(
        // color: dashboardPageController.isDarkTheme.value == true
        //     ? AppColors.dartTheme
        //     : AppColors.white,
        // elevation: 8.0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.only(top: .5),
        color: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.white,
        elevation: 20.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Visibility(
                visible:
                    controller.newsList[index].heading == null ? false : true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.newsList[index].heading == null
                        ? ""
                        : controller.newsList[index].heading!.trim(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: controller.newsList[index].newsType ==
                              "Breaking News"
                          ? AppColors.redColor
                          : dashboardPageController.isDarkTheme.value == true
                              ? AppColors.white
                              : AppColors.black,
                      fontSize: SizeConfig.newsHeadingTitleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.newsList[index].subHeading == null ||
                      controller.newsList[index].subHeading == ""
                  ? false
                  : false,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 10, bottom: 0),
                child: Visibility(
                  visible:
                      controller.newsList[index].heading == null ? false : true,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.newsList[index].subHeading == null
                          ? ""
                          : controller.newsList[index].subHeading!.trim(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: dashboardPageController.isDarkTheme.value == true
                            ? AppColors.white
                            : AppColors.greenColor,
                        fontSize: SizeConfig.newsHeadingSubTitleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: Row(
                children: [
                  Visibility(
                    visible:
                        controller.newsList[index].mediaList?.imageList == null
                            ? false
                            : true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 5, bottom: 5),
                      child: Expanded(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: controller.newsList[index].newsContent == null
                              ? MediaQuery.of(context).size.width - 40
                              : 50,
                          height: controller.newsList[index].newsContent == null
                              ? MediaQuery.of(context).size.width * (3 / 5)
                              : 65,
                          imageUrl: controller.newsList[index].mediaList
                                  ?.imageList![0].url ??
                              "",
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          controller.newsList[index].mediaList?.imageList ==
                                  null
                              ? const EdgeInsets.only(left: 10, right: 5)
                              : const EdgeInsets.only(left: 0, right: 5),
                      child: Visibility(
                        visible: controller.newsList[index].newsContent == null
                            ? false
                            : true,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.newsList[index].newsContent == null
                                ? ""
                                : controller.newsList[index].newsContent!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  dashboardPageController.isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : AppColors.black,
                              fontSize: SizeConfig.newsContentSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Visibility(
            //     visible:
            //         controller.newsList[index].newsContent == null ? false : true,
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         controller.newsList[index].newsContent == null
            //             ? ""
            //             : controller.newsList[index].newsContent!,
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //         style: TextStyle(
            //           color: dashboardPageController.isDarkTheme.value == true
            //               ? AppColors.white
            //               : AppColors.black,
            //           fontSize: SizeConfig.newsContentSize,
            //           fontWeight: FontWeight.normal,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Visibility(
            //   visible: controller.newsList[index].mediaList?.imageList == null
            //       ? false
            //       : true,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: CarouselSlider(
            //       options: CarouselOptions(
            //           enableInfiniteScroll: false,
            //           pauseAutoPlayOnTouch: true,
            //           autoPlay: false,
            //           height: MediaQuery.of(context).size.width * (3 / 4),
            //           enlargeCenterPage: true),
            //       items:
            //           controller.newsList[index].mediaList?.imageList?.map((i) {
            //         return Builder(
            //           builder: (BuildContext context) {
            //             return CachedNetworkImage(
            //               fit: BoxFit.cover,
            //               width: MediaQuery.of(context).size.width,
            //               imageUrl: i.url!,
            //               //imageUrl: AppImages.tempURL,
            //               placeholder: (context, url) => const Center(
            //                 child: SizedBox(
            //                   width: 40.0,
            //                   height: 40.0,
            //                   child: CircularProgressIndicator(),
            //                 ),
            //               ),
            //               errorWidget: (context, url, error) =>
            //                   const Icon(Icons.error),
            //             );

            //           },
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),
            Container(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.dartTheme
                  : AppColors.lightGray,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
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
                          color:
                              dashboardPageController.isDarkTheme.value == true
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
                        final heading =
                            controller.newsList[index].heading ?? "";
                        // final subHeading =
                        //     controller.newsList[index].subHeading ?? "";
                        final newsContent =
                            controller.newsList[index].newsContent ?? "";
                        final finalNewsContent = "$heading.     $newsContent";
                        if (finalNewsContent.isEmpty) {
                          return;
                        }
                        if (controller.newsList[index].isAudioPlaying == true) {
                          Utils(context).stopAudio();
                          controller.setAudioPlaying(false, index);
                        } else {
                          Utils(context).stopAudio();
                          controller.setAudioPlaying(false, selectedPosition);
                          selectedPosition = index;
                          Utils(context).startAudio(finalNewsContent);
                          controller.setAudioPlaying(true, index);
                        }
                      },
                      child: controller.newsList[index].isAudioPlaying == true
                          ? Image.asset(
                              color:
                                  dashboardPageController.isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : AppColors.black,
                              AppImages.audioPlay,
                              width: 30,
                              height: 30,
                            )
                          : Image.asset(
                              color:
                                  dashboardPageController.isDarkTheme.value ==
                                          true
                                      ? AppColors.white
                                      : AppColors.black,
                              AppImages.audioStop,
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
                          color:
                              dashboardPageController.isDarkTheme.value == true
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
                          color:
                              dashboardPageController.isDarkTheme.value == true
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
            ),
          ],
        ),
      ),
    );
  }
}
