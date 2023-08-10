import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/constants/utils.dart';
import 'package:get/get.dart';

import '../../database/app_database.dart';
import '../../models/news_list_response.dart';

class BookmarkPageController extends FullLifeCycleController {
  final AppDatabase appDatabase = Get.find<AppDatabase>();

  List<NewsList> newsList = <NewsList>[].obs;
  ScrollController controller = ScrollController();
  var isDataLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    isDataLoading.value = true;
    newsList.clear();
    await getBookmarkNews();
    isDataLoading.value = false;
  }

  void setAudioPlaying(bool istrue, int index) {
    newsList[index].isAudioPlaying = istrue;
    newsList[index] = newsList[index]; // <- Just assign
    update();
  }

  void removeBookmark(int index) async {
    newsList[index].isBookmark = false;
    newsList[index] = newsList[index]; // <- Just assign
    update();
    try {
      final newsListDao = appDatabase.newsListDao;
      await newsListDao.deleteNewsById(newsList[index].id!);
      getBookmarkNews();
      newsList.clear();
      //final bookMarkNews = await appDatabase.newsListDao.findAllNews();
      //final xx = "";
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  Future<void> getBookmarkNews() async {
    isDataLoading.value = true;
    try {
      final bookmarkNews = await appDatabase.newsListDao.findAllNews();
      if (bookmarkNews.isNotEmpty) {
        for (int i = 0; i < bookmarkNews.length; i++) {
          final news = NewsList(
              id: bookmarkNews[i].id,
              heading: bookmarkNews[i].heading,
              subHeading: bookmarkNews[i].subHeading,
              newsContent: bookmarkNews[i].newsContent,
              category: bookmarkNews[i].category,
              location: bookmarkNews[i].location,
              language: bookmarkNews[i].language,
              mediaList: MediaList(
                  imageList: Utils.convertJsonListToImageList(
                      bookmarkNews[i].imageListDb)),
              publishedOn: bookmarkNews[i].publishedOn,
              publishedBy: bookmarkNews[i].publishedBy,
              isBookmark: bookmarkNews[i].isBookmark,
              isAudioPlaying: bookmarkNews[i].isAudioPlaying);
          newsList.add(news);
          removeDuplicates(newsList);
        }
      } else {
        newsList.clear();
      }
    } on DioError catch (obj) {
      final res = (obj).response;
      if (kDebugMode) {
        print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
      }
      // FOR CUSTOM MESSAGE
      // final errorMessage = NetworkExceptions.getDioException(obj);
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Got error : $exception");
      }
    } finally {
      isDataLoading.value = false;
    }
  }

  List<T> removeDuplicates<T>(List<T> list) {
    // Convert the list to a Set to remove duplicates
    Set<T> set = Set<T>.from(list);

    // Convert the Set back to a List
    List<T> uniqueList = set.toList();

    return uniqueList;
  }
}
