import 'dart:io';
import 'package:gandiv/constants/utils.dart';
import 'package:gandiv/models/news_list_response.dart';
import 'package:get/get.dart';

class VideoPlayerPageController extends GetxController {
  final isLoading = false.obs;
  // var videoListUrl = [
  //   "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  //   "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  //   "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  //   "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  //   "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  //   "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
  // ];
  List<File> files = <File>[].obs;
  List<VideoList> videoList = <VideoList>[].obs;
  var newsList = NewsList().obs;
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    newsList = Get.arguments;
    if (newsList.value.mediaList != null &&
        newsList.value.mediaList!.videoList!.isNotEmpty) {
      for (int i = 0; i < newsList.value.mediaList!.videoList!.length; i++) {
        try {
          File file = await Utils.genThumbnailFile(
              newsList.value.mediaList!.videoList![i].url!);
          files.add(file);
        } on Exception catch (exception) {}
      }
    }
    isLoading.value = false;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Future<File> genThumbnailFile(String path) async {
  //   final fileName = await VideoThumbnail.thumbnailFile(
  //     video: path,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight:
  //         100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //     quality: 75,
  //   );
  //   File file = File(fileName!);
  //   return file;
  // }
}
