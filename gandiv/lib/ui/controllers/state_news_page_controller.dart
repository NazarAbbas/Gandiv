import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../models/news_list_response.dart';
import '../../network/rest_api.dart';

class StateNewsPageController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final RestAPI restAPI = Get.find<RestAPI>();
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

  void setBookmark(bool istrue, int index) {
    newsList[index].isBookmark = istrue;
    newsList[index] = newsList[index]; // <- Just assign
    update();
  }

  void setAudioPlaying(bool istrue, int index) {
    newsList[index].isAudioPlaying = istrue;
    newsList[index] = newsList[index]; // <- Just assign
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getHomeNews() async {
    try {
      final response = await restAPI.callNewsListApi(
          categoryId: '',
          locationId: '',
          pageNumber: pageNo,
          pageSize: pageSize);
      totalCount = response.newsListData.totalCount!;
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

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  Future<void> onResumed() async {
    // final homeNews = readNewsListJson();
    // getHomeNews();
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
