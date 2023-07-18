import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../constants/utils.dart';
import '../../database/app_database.dart';
import '../../models/news_list_db_model.dart';
import '../../models/news_list_response.dart';
import '../../network/rest_api.dart';

class HomeNewsPageController extends FullLifeCycleController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  ScrollController controller = ScrollController();
  int pageNo = 1;
  int pageSize = 10;
  int totalCount = 0;

  List<NewsList> newsList = <NewsList>[].obs;
  var isDataLoading = false.obs;
  var isLoadMoreItems = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDataLoading.value = true;
    getHomeNews();
  }

  @override
  void onReady() {
    super.onReady();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        isLoadMoreItems.value = true;
        // await Future.delayed(const Duration(seconds: 2));
        pageNo = pageNo + 1;
        pageSize = pageSize + 10;
        getHomeNews();
      }
    });
  }

  void setBookmark(int index) async {
    newsList[index].isBookmark = true;
    newsList[index] = newsList[index]; // <- Just assign
    update();
    try {
      final bookmarkNews = newsList[index];

      final newsListDB = NewsListDB(
          id: bookmarkNews.id,
          heading: bookmarkNews.heading,
          subHeading: bookmarkNews.subHeading,
          newsContent: bookmarkNews.newsContent,
          category: bookmarkNews.category,
          location: bookmarkNews.location,
          language: bookmarkNews.language,
          imageListDb: newsList[index].mediaList?.imageList == null
              ? null
              : Utils.convertImageListToJsonList(
                  newsList[index].mediaList?.imageList),
          videoListDb: newsList[index].mediaList?.videoList == null
              ? null
              : Utils.convertVideoListToJsonList(
                  newsList[index].mediaList?.videoList),
          audioListDb: newsList[index].mediaList?.imageList == null
              ? null
              : Utils.convertAudioListToJsonList(
                  newsList[index].mediaList?.audioList),
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

  void removeBookmark(int index) async {
    newsList[index].isBookmark = false;
    newsList[index] = newsList[index]; // <- Just assign
    update();
    try {
      final newsListDao = appDatabase.newsListDao;
      await newsListDao.deleteNewsById(newsList[index].id!);
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  void setAudioPlaying(bool istrue, int index) {
    newsList[index].isAudioPlaying = istrue;
    newsList[index] = newsList[index]; // <- Just assign
    update();
  }

  Future<void> getHomeNews() async {
    try {
      final response = await restAPI.callNewsListApi(
          categoryId: '',
          locationId: '',
          pageNumber: pageNo,
          pageSize: pageSize);
      totalCount = response.newsListData.totalCount!;
      for (int i = 0; i < response.newsListData.newsList.length; i++) {
        final bookMarkNews = await appDatabase.newsListDao
            .findNewsById(response.newsListData.newsList[i].id!);
        if (bookMarkNews != null) {
          response.newsListData.newsList[i].isBookmark = true;
        }
      }
      newsList.addAll(response.newsListData.newsList);
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
      isLoadMoreItems.value = false;
    }
  }

  // Fetch json content from the assests file
  // Future<List<NewsList>> readNewsListJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/jsonfiles/news_list.json');
  //   final jsondata = await json.decode(response);
  //   final newsList =
  //       (jsondata as List).map((data) => NewsList.fromJson(data)).toList();
  //   return newsList;
  // }
}
