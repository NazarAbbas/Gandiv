import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/ui/controllers/location_page_controller.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import '../../../constants/utils.dart';
import '../../../constants/values/app_images.dart';
import '../../../database/app_database.dart';
import '../../../route_management/routes.dart';
import '../../controllers/dashboard_page_cotroller.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

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
  LocationPagePageListRow createState() => LocationPagePageListRow();
}

class LocationPagePageListRow extends State<LocationPage> {
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();
  LocationPageController controller = Get.find<LocationPageController>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();

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
                              child: ListView.builder(
                                //key: const PageStorageKey(0),
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: controller.newsList.length,
                                controller: controller.controller,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Utils(context).stopAudio(controller
                                                  .newsList[selectedPosition]
                                                  .newsContent ==
                                              null
                                          ? ""
                                          : controller
                                              .newsList[selectedPosition]
                                              .newsContent!),
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
                    // ignore: unrelated_type_equality_checks
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
      ),
    );
  }

  int selectedPosition = 0;
  Obx rowWidget(int index, BuildContext context) {
    return Obx(
      () => Card(
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
                visible: controller.newsList[index].newsContent == null
                    ? false
                    : true,
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
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      pauseAutoPlayOnTouch: false,
                      autoPlay: false,
                      height: MediaQuery.of(context).size.width * (3 / 4),
                      enlargeCenterPage: true),
                  items:
                      controller.newsList[index].mediaList?.imageList?.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: i.url!,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                        // return Image.network(
                        //   fit: BoxFit.cover,
                        //   i.url!,
                        //   width: MediaQuery.of(context).size.width,
                        //   loadingBuilder: (BuildContext context, Widget child,
                        //       ImageChunkEvent? loadingProgress) {
                        //     if (loadingProgress == null) return child;
                        //     return Center(
                        //       child: CircularProgressIndicator(
                        //         value: loadingProgress.expectedTotalBytes !=
                        //                 null
                        //             ? loadingProgress.cumulativeBytesLoaded /
                        //                 loadingProgress.expectedTotalBytes!
                        //             : null,
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                    );
                  }).toList(),
                ),

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
                      height: 20,
                      width: 20,
                    ),
                  ),
                  Center(
                    child: Text(
                      '5 mins read',
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
                        Share.share('check out my website https://example.com');
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
      ),
    );
  }
}
