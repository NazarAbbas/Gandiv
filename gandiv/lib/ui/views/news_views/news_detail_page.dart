import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/models/news_list_response.dart';
import 'package:gandiv/ui/controllers/news_details_page_controller.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import '../../../constants/utils.dart';
import '../../../constants/values/app_colors.dart';
import '../../../constants/values/app_images.dart';
import '../../../route_management/routes.dart';
import '../../controllers/dashboard_page_cotroller.dart';

// ignore: must_be_immutable

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key});

  @override
  NewsDetailPageColumn createState() => NewsDetailPageColumn();
}

class NewsDetailPageColumn extends State<NewsDetailPage> {
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();

  NewsDetailsPageController controller = Get.find<NewsDetailsPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildAppBar(),
      ),
      body: Column(
        children: [columnWidget(0, context)],
      ),
    );
  }

  Obx buildAppBar() {
    return Obx(
      () => AppBar(
        backgroundColor: dashboardPageController.isDarkTheme.value == true
            ? AppColors.dartTheme
            : AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'news_details'.tr,
            style: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: dashboardPageController.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.black),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              color: dashboardPageController.isDarkTheme.value == true
                  ? controller.newsList.value.isAudioPlaying == true
                      ? AppColors.colorPrimary
                      : AppColors.white
                  : controller.newsList.value.isAudioPlaying == true
                      ? AppColors.colorPrimary
                      : AppColors.black,
              AppImages.audio,
              width: 30,
              height: 30,
            ),
            onPressed: () {
              if (controller.newsList.value.isAudioPlaying == true) {
                Utils(context)
                    .stopAudio(controller.newsList.value.newsContent!);
                controller.setAudioPlaying(false);
              } else {
                Utils(context)
                    .startAudio(controller.newsList.value.newsContent!);
                controller.setAudioPlaying(true);
              }
              setState(() {});
              //Get.toNamed(Routes.searchPage);
            },
          ),
          IconButton(
            icon: Image.asset(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.white
                  : AppColors.colorPrimary,
              controller.newsList.value.isBookmark == true
                  ? AppImages.highLightBookmark
                  : AppImages.bookmark,
              width: 25,
              height: 25,
            ),
            onPressed: () {
              if (controller.newsList.value.isBookmark == true) {
                controller.removeBookmark(controller.newsList.value);
              } else {
                controller.setBookmark(controller.newsList.value);
              }
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    AppImages.share,
                    fit: BoxFit.contain,
                    width: 35,
                    height: 35,
                    color: dashboardPageController.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.black,
                  ),
                  onPressed: () {
                    Share.share('check out my website https://example.com');
                  },
                ),
                // Positioned(
                //   top: 35,
                //   bottom: 0,
                //   left: 20,
                //   right: 0,
                //   child: Text(
                //     '.',
                //     style: TextStyle(
                //       color: AppColors.colorPrimary,
                //       //code here
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Obx columnWidget(int index, BuildContext context) {
    return Obx(
      () => Expanded(
        child: SingleChildScrollView(
          child: Card(
            color: dashboardPageController.isDarkTheme.value == true
                ? AppColors.dartTheme
                : AppColors.white,
            elevation: 8.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.newsList.value.heading!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.newsList.value.subHeading == null
                      ? false
                      : true,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        controller.newsList.value.subHeading == null
                            ? ""
                            : controller.newsList.value.subHeading!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      controller.newsList.value.mediaList?.imageList == null
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
                      items: controller.newsList.value.mediaList?.imageList!
                          .map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.network(
                              fit: BoxFit.cover,
                              i.url!,
                              width: MediaQuery.of(context).size.width,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.newsList.value!.newsContent!,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
