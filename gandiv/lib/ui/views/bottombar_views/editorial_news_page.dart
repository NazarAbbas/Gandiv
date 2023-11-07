import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/constants/values/size_config.dart';
import 'package:gandiv/ui/controllers/breaking_news_page_controller.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import '../../../constants/tts_utils.dart';
import '../../../constants/utils.dart';
import '../../../constants/values/app_images.dart';
import '../../../database/app_database.dart';
import '../../../route_management/routes.dart';
import '../../controllers/dashboard_page_cotroller.dart';
import '../../controllers/editorial_news_page_controller.dart';

class EditorialNewsPage extends StatefulWidget {
  const EditorialNewsPage({super.key});

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
  EditorialNewsPageListRow createState() => EditorialNewsPageListRow();
}

class EditorialNewsPageListRow extends State<EditorialNewsPage> {
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();
  EditorialNewsPageController controller =
      Get.find<EditorialNewsPageController>();

  Future<void> _pullRefresh() async {
    controller.pageNo = 1;
    controller.pageSize = 5;
    controller.newsList.clear();
    controller.onInit();
  }

  @override
  void initState() {
    super.initState();
    controller.pageNo = 1;
    controller.pageSize = 5;
    controller.newsList.clear();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                                color:
                                    dashboardPageController.isDarkTheme.value ==
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
                                  //key: const PageStorageKey(0),
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: controller.newsList.length,
                                  controller: controller.controller,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => {
                                        Utils(context).stopAudio(),
                                        controller.setAudioPlaying(
                                            false, selectedPosition),
                                        Get.toNamed(Routes.newsDetailPage,
                                                arguments:
                                                    controller.newsList[index])
                                            ?.then(
                                          (value) => {controller.onInit()},
                                        )
                                      },
                                      child: rowWidget(index, context),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                    // ignore: unrelated_type_equality_checks
                    if (controller.isLoadMoreItems.value == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 40),
                        child: Center(
                          child: Column(
                            children: [
                              Text('loading'.tr,
                                  style: TextStyle(
                                      color: dashboardPageController
                                                  .isDarkTheme.value ==
                                              true
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              CircularProgressIndicator(
                                color:
                                    dashboardPageController.isDarkTheme.value ==
                                            true
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
                    : true,
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
                          controller.newsList[index].mediaList?.imageList ==
                                  null
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
                        //  ),
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

              // child: CarouselSlider(
              //   options: CarouselOptions(
              //       initialPage: 0,
              //       enableInfiniteScroll: false,
              //       pauseAutoPlayOnTouch: false,
              //       autoPlay: false,
              //       height: MediaQuery.of(context).size.width * (3 / 4),
              //       enlargeCenterPage: true,
              //       onPageChanged: (index, reason) {
              //         //final xx = index;
              //       }),
              //   items:
              //       controller.newsList[index].mediaList?.imageList?.map((i) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return CachedNetworkImage(
              //           fit: BoxFit.cover,
              //           width: MediaQuery.of(context).size.width,
              //           imageUrl: i.url!,
              //           //imageUrl: AppImages.tempURL,
              //           placeholder: (context, url) => const Center(
              //             child: SizedBox(
              //               width: 40.0,
              //               height: 40.0,
              //               child: CircularProgressIndicator(),
              //             ),
              //           ),
              //           errorWidget: (context, url, error) =>
              //               const Icon(Icons.error),
              //         );
              //       },
              //     );
              //   }).toList(),
              // ),

              // child: Image.network(
              //   controller.newsList[index].mediaList[0].url ??
              //       'https://avatars.githubusercontent.com/u/1?v=4"',

              //   height: MediaQuery.of(context).size.width * (3 / 4),
              //   width: MediaQuery.of(context).size.width,
              //   loadingBuilder: (BuildContext context, Widget child,
              //       ImageChunkEvent? loadingProgress) {
              //     if (loadingProgress == null) return child;
              //     return Center(
              //       child: CircularProgressIndicator(
              //         value: loadingProgress.expectedTotalBytes != null
              //             ? loadingProgress.cumulativeBytesLoaded /
              //                 loadingProgress.expectedTotalBytes!
              //             : null,
              //       ),
              //     );
              //   },
              // ),
              //  ),
              //),
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
                              "$heading.  $subHeading.    $newsContent";
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
                            // Utils.ftts.setCompletionHandler(() {
                            //   Utils(context).stopAudio(newsContent);
                            //   controller.setAudioPlaying(false, index);
                            // });
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
                            // Share.share('check out my website https://example.com');
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
