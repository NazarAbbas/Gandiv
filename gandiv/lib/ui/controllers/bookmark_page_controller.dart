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
    // ignore: unrelated_type_equality_checks
    if (isDataLoading == false) {
      isDataLoading.value = true;
      newsList.clear();
      await getBookmarkNews();
    }
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
              categories: Utils.convertStringToCategoriesList(
                  bookmarkNews[i].categoryList),
              location: bookmarkNews[i].location,
              language: bookmarkNews[i].language,
              mediaList: MediaList(
                  imageList: Utils.convertJsonListToImageList(
                      bookmarkNews[i].imageListDb)),
              publishedOn: bookmarkNews[i].publishedOn,
              publishedBy: bookmarkNews[i].publishedBy,
              isBookmark: bookmarkNews[i].isBookmark,
              durationInMin: bookmarkNews[i].durationInMin,
              newsType: bookmarkNews[i].newsType,
              isAudioPlaying: bookmarkNews[i].isAudioPlaying);
          newsList.add(news);
        }

        final uniqueLis = removeDuplicates(newsList);
        newsList.clear();
        newsList.addAll(uniqueLis);
      } else {
        newsList.clear();
      }
    } on DioException catch (obj) {
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
    return list.toSet().toList();
  }
}
