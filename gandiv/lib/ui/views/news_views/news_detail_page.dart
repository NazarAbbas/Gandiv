import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/ui/controllers/news_details_page_controller.dart';
import 'package:get/get.dart';
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
    return Obx(
      () => WillPopScope(
        onWillPop: () {
          if (controller.newsList.value.isAudioPlaying == true) {
            Utils(context).stopAudio(controller.newsList.value.newsContent!);
            controller.setAudioPlaying(false);
          }
          //trigger leaving and use own data
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: buildAppBar(),
          ),
          body: controller.isLoading.value
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.transparent,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Column(
                  children: [columnWidget(0, context)],
                ),
        ),
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
                    width: 25,
                    height: 25,
                    color: dashboardPageController.isDarkTheme.value == true
                        ? AppColors.white
                        : AppColors.black,
                  ),
                  onPressed: () {
                    Utils.share(controller.newsList.value);
                    //Share.share('check out my website https://example.com');
                  },
                ),
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
          child: Expanded(
            child: Card(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.dartTheme
                  : AppColors.white,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  headingWidget(),
                  subHeadingWidget(),
                  imagesWidget(context),
                  contentWidget(),
                  // controller.newsList.value.mediaList != null &&
                  //         controller.newsList.value.mediaList!.videoList !=
                  //             null &&
                  //         controller
                  //             .newsList.value.mediaList!.videoList!.isNotEmpty
                  //     ? videoWidget()
                  //     : emptyWidget(),
                  // controller.newsList.value.mediaList != null &&
                  //         controller.newsList.value.mediaList!.audioList !=
                  //             null &&
                  //         controller
                  //             .newsList.value.mediaList!.videoList!.isNotEmpty
                  //     ? audioWidget()
                  //     : emptyWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding contentWidget() {
    return Padding(
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
    );
  }

  Visibility imagesWidget(BuildContext context) {
    return Visibility(
      visible: (controller.newsList.value.mediaList?.imageList == null ||
              controller.newsList.value.mediaList?.imageList?.length == 0)
          ? false
          : true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CarouselSlider(
          options: CarouselOptions(
              enableInfiniteScroll: false,
              pauseAutoPlayOnTouch: true,
              autoPlay: false,
              height: MediaQuery.of(context).size.width * (3 / 4),
              enlargeCenterPage: true),
          items: controller.newsList.value.mediaList?.imageList!.map((i) {
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                //         value: loadingProgress.expectedTotalBytes != null
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
      ),
    );
  }

  Visibility subHeadingWidget() {
    return Visibility(
      visible: controller.newsList.value.subHeading == null ? false : true,
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
    );
  }

  Padding headingWidget() {
    return Padding(
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
    );
  }

  SizedBox emptyWidget() {
    return const SizedBox(height: 10);
  }

  Visibility videoWidget() {
    return Visibility(
      visible: (controller.newsList.value.mediaList == null ||
              controller.newsList.value.mediaList?.videoList?.length == 0)
          ? true
          : true,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.videoPlayerPage, arguments: controller.newsList)
              ?.then(
            (value) => {
              controller.onInit(),
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
          child: Stack(
            children: [
              Image.file(
                controller.files[0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 150),
                child: Image.asset(
                  width: 50,
                  height: 50,
                  AppImages.videoPlayIcon,
                  fit: BoxFit.cover,
                  color: AppColors.colorPrimary,
                ),
              ),
            ],
          ),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.only(top: 5),
        //   child: Image.asset(
        //     AppImages.videoPlayerIcon,
        //   ),
        // ),
      ),
    );
  }

  Visibility audioWidget() {
    return Visibility(
      visible: (controller.newsList.value.mediaList == null ||
              controller.newsList.value.mediaList?.audioList?.length == 0)
          ? true
          : true,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.audioPlayerPage, arguments: controller.newsList)
              ?.then(
            (value) => {
              controller.onInit(),
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
          child: Stack(
            children: [
              Image.asset(
                AppImages.audioPlayer,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 90, left: 150),
              //   child: Image.asset(
              //     width: 50,
              //     height: 50,
              //     AppImages.videoPlayIcon,
              //     fit: BoxFit.cover,
              //     color: AppColors.colorPrimary,
              //   ),
              // ),
            ],
          ),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.only(top: 5),
        //   child: Image.asset(
        //     AppImages.videoPlayerIcon,
        //   ),
        // ),
      ),
    );
  }
}
