import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/tts_utils.dart';
import 'package:gandiv/ui/controllers/news_details_page_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/utils.dart';
import '../../../constants/values/app_colors.dart';
import '../../../constants/values/app_images.dart';
import '../../../constants/values/size_config.dart';
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
            // Utils(context).stopAudio(controller.newsList.value.newsContent!);
            TtsUtills.stopAudio();
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

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: dashboardPageController.isDarkTheme.value == true
          ? AppColors.dartTheme
          : AppColors.colorPrimary,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          'news_details'.tr,
          style: TextStyle(
            color: dashboardPageController.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.white,
          ),
        ),
      ),
      iconTheme: IconThemeData(
          color: dashboardPageController.isDarkTheme.value == true
              ? AppColors.white
              : AppColors.white),
      actions: <Widget>[
        IconButton(
          icon: controller.newsList.value.isAudioPlaying == true
              ? Image.asset(
                  color: dashboardPageController.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.white,
                  AppImages.audioPlay,
                  width: 30,
                  height: 30,
                )
              : Image.asset(
                  color: dashboardPageController.isDarkTheme.value == true
                      ? AppColors.white
                      : AppColors.white,
                  AppImages.audioStop,
                  width: 30,
                  height: 30,
                ),
          onPressed: () {
            if (controller.newsList.value.isAudioPlaying == true) {
              TtsUtills.stopAudio();
              controller.setAudioPlaying(false);
            } else {
              final heading = controller.newsList.value.heading ?? "";
              final subHeading = controller.newsList.value.subHeading ?? "";
              final newsContent = controller.newsList.value.newsContent ?? "";
              final finalNewsContent = "$heading. $subHeading. $newsContent";
              if (finalNewsContent.isEmpty) {
                return;
              }
              TtsUtills.startAudio(finalNewsContent);
              controller.setAudioPlaying(true);
            }
            setState(() {});
          },
        ),
        IconButton(
          icon: Image.asset(
            color: dashboardPageController.isDarkTheme.value == true
                ? AppColors.white
                : AppColors.white,
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
                      : AppColors.white,
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
    );
  }

  Expanded columnWidget(int index, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        // child: Card(
        //   color: dashboardPageController.isDarkTheme.value == true
        //       ? AppColors.dartTheme
        //       : AppColors.white,
        //   elevation: 8.0,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            headingWidget(),
            imagesWidget(context),
            subHeadingWidget(),
            Visibility(
                visible: controller.advertisementList.isEmpty ? false : true,
                child: lisViewHeader()),
            contentWidget(),
          ],
        ),
      ),
      //  ),
    );
  }

  Padding lisViewHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        options: CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll:
                controller.advertisementList.length == 1 ? false : true,
            pauseAutoPlayOnTouch: false,
            autoPlay: controller.advertisementList.length == 1 ? false : true,
            height: MediaQuery.of(context).size.width * (3 / 6),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              //final xx = index;
            }),
        items: controller.advertisementList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () async {
                    if (i.url != null && i.url.isNotEmpty)
                    // ignore: curly_braces_in_flow_control_structures
                    if (!await launchUrl(Uri.parse(i.url))) {}
                  },
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: i.imageUrl,
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
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Visibility contentWidget() {
    return Visibility(
      visible: controller.newsList.value.newsContent == null ? false : true,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 50),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            textAlign: TextAlign.left,
            controller.newsList.value.newsContent == null
                ? ""
                : controller.newsList.value.newsContent!,
            style: TextStyle(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.white
                  : AppColors.black,
              fontSize: SizeConfig.newsContentSize,
              fontWeight: FontWeight.normal,
            ),
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
        padding: const EdgeInsets.all(5),
        child: CarouselSlider(
          options: CarouselOptions(
              enableInfiniteScroll: false,
              pauseAutoPlayOnTouch: true,
              autoPlay: false,
              height: MediaQuery.of(context).size.width * (3 / 6),
              enlargeCenterPage: true),
          items: controller.newsList.value.mediaList?.imageList!.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: i.url!,
                  //imageUrl: AppImages.tempURL,
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
            style: TextStyle(
              fontSize: SizeConfig.newsHeadingSubTitleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Padding headingWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          controller.newsList.value.heading!,
          style: TextStyle(
            fontSize: SizeConfig.newsHeadingTitleSize,
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
