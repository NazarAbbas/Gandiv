import 'dart:io';
import 'package:gandiv/models/news_list_response.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPlayerPageController extends GetxController {
  var videoListUrl = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
  ];
  List<File> files = <File>[].obs;
  List<VideoList> videoList = <VideoList>[].obs;
  var newsList = NewsList().obs;
  @override
  void onInit() async {
    super.onInit();
    newsList = Get.arguments;
    if (newsList.value.mediaList != null &&
        newsList.value.mediaList?.videoList?.length == 0) {
      for (int i = 0; i < videoListUrl.length; i++) {
        VideoList video =
            VideoList(url: videoListUrl[i], type: "mp4", placeholder: "");
        videoList.add(video);
      }
      newsList.value.mediaList?.videoList?.addAll(videoList);
    }

    for (int i = 0; i < newsList.value.mediaList!.videoList!.length; i++) {
      File file = await genThumbnailFile(videoListUrl[i]);
      files.add(file);
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<File> genThumbnailFile(String path) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight:
          100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    File file = File(fileName!);
    return file;
  }
}
