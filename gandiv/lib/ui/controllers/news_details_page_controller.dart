import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../constants/utils.dart';
import '../../database/app_database.dart';
import '../../models/news_list_db_model.dart';
import '../../models/news_list_response.dart';

class NewsDetailsPageController extends FullLifeCycleController {
  var newsList = NewsList().obs;
  final AppDatabase appDatabase = Get.find<AppDatabase>();

  @override
  void onInit() {
    super.onInit();
    newsList.value = Get.arguments;
  }

  void setAudioPlaying(bool istrue) {
    newsList.value.isAudioPlaying = istrue;
    newsList = newsList; // <- Just assign
    update();
  }

  void setBookmark(NewsList newsList) async {
    newsList.isBookmark = true;
    newsList = newsList; // <- Just assign
    update();
    try {
      final bookmarkNews = newsList;
      final newsListDB = NewsListDB(
          id: bookmarkNews.id,
          heading: bookmarkNews.heading,
          subHeading: bookmarkNews.subHeading,
          newsContent: bookmarkNews.newsContent,
          category: bookmarkNews.category,
          location: bookmarkNews.location,
          language: bookmarkNews.language,
          imageListDb: newsList.mediaList?.imageList == null
              ? null
              : Utils.convertImageListToJsonList(
                  newsList.mediaList!.imageList!),
          videoListDb: newsList.mediaList?.videoList == null
              ? null
              : Utils.convertVideoListToJsonList(
                  newsList.mediaList!.videoList!),
          audioListDb: newsList.mediaList?.audioList == null
              ? null
              : Utils.convertAudioListToJsonList(
                  newsList.mediaList!.audioList!),
          publishedOn: bookmarkNews.publishedOn,
          publishedBy: bookmarkNews.publishedBy,
          isBookmark: bookmarkNews.isBookmark,
          isAudioPlaying: bookmarkNews.isAudioPlaying);
      final newsListDao = appDatabase.newsListDao;
      await newsListDao.insertNews(newsListDB);
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  void removeBookmark(NewsList newsList) async {
    newsList.isBookmark = false;
    //newsList.isBookmark = newsList; // <- Just assign
    update();
    try {
      final newsListDao = appDatabase.newsListDao;
      await newsListDao.deleteNewsById(newsList.id!);
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}