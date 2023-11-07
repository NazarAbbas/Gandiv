import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../constants/utils.dart';
import '../../database/app_database.dart';
import '../../database/entity/advertisement_list_db_model.dart';
import '../../models/custom_advertisement_list.dart';
import '../../models/news_list_db_model.dart';
import '../../models/news_list_response.dart';

class NewsDetailsPageController extends FullLifeCycleController {
  var newsList = NewsList().obs;
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  final isLoading = false.obs;
  List<File> files = <File>[].obs;
  List<CustomAdvertisementList> advertisementList =
      <CustomAdvertisementList>[].obs;

  @override
  void onInit() async {
    super.onInit();

    isLoading.value = true;

    newsList.value = Get.arguments; //[...Get.arguments];
    if (newsList.value.mediaList != null &&
        newsList.value.mediaList!.videoList != null &&
        newsList.value.mediaList!.videoList!.isNotEmpty) {
      try {
        for (int i = 0; i < newsList.value.mediaList!.videoList!.length; i++) {
          File file = await Utils.genThumbnailFile(
              newsList.value.mediaList!.videoList![i].url!);
          files.add(file);
        }
      } on Exception catch (exception) {}
    }

    List<AdvertisementDb> listAdvertisementDb =
        await appDatabase.advertisementDao.findAllAdvertisement();
    for (int i = 0; i < listAdvertisementDb.length; i++) {
      if (listAdvertisementDb[i].placeHolder == "Detail") {
        CustomAdvertisementList customAdvertisementList =
            CustomAdvertisementList(
                id: listAdvertisementDb[i].id,
                url: listAdvertisementDb[i].url,
                placeHolder: listAdvertisementDb[i].placeHolder,
                imageUrl: listAdvertisementDb[i].mediaList);

        advertisementList.add(customAdvertisementList);
      }
    }

    isLoading.value = false;
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
          categoryList:
              Utils.convertCategoriesListToJson(bookmarkNews.categories),
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
          durationInMin: bookmarkNews.durationInMin,
          newsType: bookmarkNews.newsType,
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
