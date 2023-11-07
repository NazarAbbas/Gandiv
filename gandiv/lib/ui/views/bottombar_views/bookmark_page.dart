import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/size_config.dart';
import 'package:get/get.dart';

import '../../../constants/tts_utils.dart';
import '../../../constants/utils.dart';
import '../../../constants/values/app_colors.dart';
import '../../../constants/values/app_images.dart';
import '../../../route_management/routes.dart';
import '../../controllers/bookmark_page_controller.dart';
import '../../controllers/dashboard_page_cotroller.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});
  @override
  BookmarkPageListRow createState() => BookmarkPageListRow();
}

class BookmarkPageListRow extends State<BookmarkPage> {
  Future<void> _pullRefresh() async {
    controller.newsList.clear();
    controller.onInit();
  }

  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  BookmarkPageController controller = Get.find<BookmarkPageController>();

  @override
  void dispose() {
    super.dispose();
    try {
      if (controller.newsList.isNotEmpty) {
        if (controller.newsList[selectedPosition].isAudioPlaying == true) {
          Future.delayed(Duration.zero, () async {
            TtsUtills.stopAudio();
            controller.setAudioPlaying(false, selectedPosition);
          });
        }
      }
    } on Exception catch (exception) {
      final message = exception.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // controller.onInit();
        return false;
      },
      child: Obx(
        () => SafeArea(
          child: Scaffold(
            body: controller.isDataLoading.value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.transparent,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: controller.newsList.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: dashboardPageController
                                              .isDarkTheme.value ==
                                          true
                                      ? AppColors.dartTheme
                                      : AppColors.white,
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
                            : RefreshIndicator(
                                color: AppColors.colorPrimary,
                                onRefresh: _pullRefresh,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: controller.newsList.length,
                                    controller: controller.controller,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () => {
                                                TtsUtills.stopAudio(),
                                                // Utils(context).stopAudio(controller
                                                //             .newsList[
                                                //                 selectedPosition]
                                                //             .newsContent ==
                                                //         null
                                                //     ? ""
                                                //     : controller
                                                //         .newsList[
                                                //             selectedPosition]
                                                //         .newsContent!),
                                                controller.setAudioPlaying(
                                                    false, selectedPosition),
                                                Get.toNamed(
                                                        Routes.newsDetailPage,
                                                        arguments: controller
                                                            .newsList[index])
                                                    ?.then(
                                                  (value) => {
                                                    controller.onInit(),
                                                  },
                                                )
                                              },
                                          child: rowWidget(index, context));
                                    },
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  int selectedPosition = 0;
  Obx rowWidget(int index, BuildContext context) {
    return Obx(
      () => Container(
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
                    visible: controller.newsList[index].heading == null
                        ? false
                        : true,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        controller.newsList[index].subHeading == null
                            ? ""
                            : controller.newsList[index].subHeading!.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              dashboardPageController.isDarkTheme.value == true
                                  ? AppColors.greenColor
                                  : AppColors.greenColor,
                          fontSize: SizeConfig.newsHeadingSubTitleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Visibility(
              //     visible: controller.newsList[index].newsContent == null
              //         ? false
              //         : true,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Row(
                  children: [
                    Visibility(
                      visible:
                          controller.newsList[index].mediaList?.imageList ==
                                      null ||
                                  controller.newsList[index].mediaList
                                          ?.imageList?.length ==
                                      0
                              ? false
                              : true,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 5, bottom: 5),
                        //child: Expanded(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: controller.newsList[index].newsContent == null
                              ? MediaQuery.of(context).size.width - 40
                              : 50,
                          height: controller.newsList[index].newsContent == null
                              ? MediaQuery.of(context).size.width * (3 / 6)
                              : 65,
                          imageUrl: controller.newsList[index].mediaList
                                      ?.imageList?.length ==
                                  0
                              ? ""
                              : controller.newsList[index].mediaList
                                      ?.imageList?[0].url ??
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
                        // ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            controller.newsList[index].mediaList?.imageList ==
                                    null
                                ? const EdgeInsets.only(left: 10, right: 5)
                                : const EdgeInsets.only(left: 10, right: 5),
                        child: Visibility(
                          visible:
                              controller.newsList[index].newsContent == null
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
              // Visibility(
              //   visible: (controller.newsList[index].mediaList?.imageList ==
              //               null ||
              //           controller.newsList[index].mediaList?.imageList?.length ==
              //               0)
              //       ? false
              //       : true,
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: CarouselSlider(
              //       options: CarouselOptions(
              //           initialPage: 0,
              //           enableInfiniteScroll: false,
              //           pauseAutoPlayOnTouch: false,
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
              //               // imageUrl: AppImages.tempURL,
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
                          color:
                              dashboardPageController.isDarkTheme.value == true
                                  ? AppColors.white
                                  : AppColors.black,
                          AppImages.clock,
                          height: 20,
                          width: 20,
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
                            color: dashboardPageController.isDarkTheme.value ==
                                    true
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
                          final subHeading =
                              controller.newsList[index].subHeading ?? "";
                          final newsContent =
                              controller.newsList[index].newsContent ?? "";
                          final finalNewsContent =
                              "$heading.  $subHeading.   $newsContent";
                          if (finalNewsContent.isEmpty) {
                            return;
                          }
                          if (controller.newsList[index].isAudioPlaying ==
                              true) {
                            TtsUtills.stopAudio();
                            controller.setAudioPlaying(false, index);
                          } else {
                            TtsUtills.stopAudio();
                            controller.setAudioPlaying(false, selectedPosition);
                            selectedPosition = index;
                            TtsUtills.startAudio(finalNewsContent);

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
                            controller.removeBookmark(index);
                          },
                          child: Image.asset(
                            color: dashboardPageController.isDarkTheme.value ==
                                    true
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
                            //Share.share('check out my website https://example.com');
                          },
                          child: Image.asset(
                            color: dashboardPageController.isDarkTheme.value ==
                                    true
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
      ),
    );
  }
}
