import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../database/app_database.dart';
import '../../models/news_list_response.dart';

class BookmarkPageController extends GetxController {
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  List<NewsList> newsList = <NewsList>[].obs;
  ScrollController controller = ScrollController();

  var isDataLoading = false.obs;
  var isLoadMoreItems = false.obs;
  @override
  void onInit() {
    super.onInit();
    getBookmarkNews();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setAudioPlaying(bool istrue, int index) {
    newsList[index].isAudioPlaying = istrue;
    newsList[index] = newsList[index]; // <- Just assign
    update();
  }

  Future<void> getBookmarkNews() async {
    try {
      final bookmarkNews = await appDatabase.newsListDao.findAllNews();
      newsList.addAll(bookmarkNews);
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
      //  isDataLoading.value = false;
      // isLoadMoreItems.value = false;
    }
  }
}
