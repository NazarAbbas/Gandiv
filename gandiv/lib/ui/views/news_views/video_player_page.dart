import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_images.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/values/app_colors.dart';
import '../../controllers/video_player_page_controller.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerPage createState() => _VideoPlayerPage();
}

class _VideoPlayerPage extends State<VideoPlayerPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chiewController;

  VideoPlayerPageController controller = Get.find<VideoPlayerPageController>();
  DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();
  @override
  void initState() {
    super.initState();
    initializeChieweController(
        controller.newsList.value.mediaList!.videoList![0].url);
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chiewController?.dispose();
    super.dispose();
  }

  void initializeChieweController(String? videoUrl) {
    // ignore: deprecated_member_use
    _videoPlayerController = VideoPlayerController.network(videoUrl!);
    _chiewController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: 5 / 3,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('video'),
          backgroundColor: AppColors.colorPrimary,
        ),
        body: controller.isLoading.value
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.transparent,
                child: const Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Container(
                    color: AppColors.colorPrimary.withOpacity(.5),
                    height: 350,
                    width: double.infinity,
                    child: Chewie(
                      controller: _chiewController!,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.files.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => {
                            setState(() {
                              _videoPlayerController?.dispose();
                              _chiewController?.dispose();
                              initializeChieweController(controller.newsList
                                  .value.mediaList!.videoList![index].url);
                            })
                          },
                          child: Card(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              child: Expanded(
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Image.file(
                                          controller.files[index],
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 35, left: 35),
                                          child: Image.asset(
                                            width: 35,
                                            height: 35,
                                            AppImages.videoPlayIcon,
                                            fit: BoxFit.cover,
                                            color: AppColors.colorPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          controller.newsList.value.mediaList!
                                              .videoList![index].url!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: dashboardPageController
                                                        .isDarkTheme.value ==
                                                    true
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
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
