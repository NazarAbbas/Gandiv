import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/models/advertisement_response.dart' as advertisement;
import 'package:gandiv/models/custom_advertisement_list.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constant.dart';
import '../../constants/dialog_utils.dart';
import '../../constants/utils.dart';
import '../../database/app_database.dart';
import '../../database/entity/advertisement_list_db_model.dart';
import '../../models/news_list_db_model.dart';
import '../../models/news_list_response.dart';
import '../../network/rest_api.dart';

class HomeNewsPageController extends FullLifeCycleController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  //ScrollController controller = ScrollController();
  late ScrollController controller;
  RxInt audioPlayingIndex = 0.obs;
  int pageNo = 1;
  int pageSize = 5;
  int totalCount = 0;

  List<NewsList> newsList = <NewsList>[].obs;
  List<CustomAdvertisementList> advertisementList =
      <CustomAdvertisementList>[].obs;
  var isDataLoading = false.obs;
  var isLoadMoreItems = false.obs;

  var locationId = '';
  var categoryId = '';
  int languageId = 0;

  @override
  void onInit() async {
    super.onInit();
    controller = ScrollController();

    Future.delayed(Duration.zero, () async {
      if (isDataLoading.value == false) {
        isDataLoading.value = true;
        advertisementList.clear();
        List<AdvertisementDb> listAdvertisementDb =
            await appDatabase.advertisementDao.findAllAdvertisement();

        for (int i = 0; i < listAdvertisementDb.length; i++) {
          // final mediaList =
          //     Utils.convertJsonListToMediaList(listAdvertisementDb[i].mediaList);
          //  for (int j = 0; j < mediaList.length; j++) {
          if (listAdvertisementDb[i].placeHolder == "Header") {
            CustomAdvertisementList customAdvertisementList =
                CustomAdvertisementList(
                    id: listAdvertisementDb[i].id,
                    url: listAdvertisementDb[i].url,
                    placeHolder: listAdvertisementDb[i].placeHolder,
                    imageUrl: listAdvertisementDb[i].mediaList);

            advertisementList.add(customAdvertisementList);
          }
          // }
        }

        if (newsList.isNotEmpty) {
          for (int i = 0; i < newsList.length; i++) {
            final bookMarkNews =
                await appDatabase.newsListDao.findNewsById(newsList[i].id!);
            if (bookMarkNews != null) {
              newsList[i].isBookmark = true;
            } else {
              newsList[i].isBookmark = false;
            }
            isDataLoading.value = false;
            isLoadMoreItems.value = false;
          }
        } else {
          if (controller.hasClients) {
            controller.jumpTo(0);
          }
          languageId = GetStorage().read(Constant.selectedLanguage);
          pageNo = 1;
          pageSize = 5;
          newsList.clear();
          await getHomeNews();
        }
      }
    });
  }

  void setCategoryId(String categoryId) async {
    this.categoryId = categoryId;
    await Future.delayed(Duration.zero, () async {
      newsList.clear();
    });
  }

  @override
  void onReady() {
    super.onReady();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels &&
          totalCount > newsList.length &&
          isLoadMoreItems.value == false) {
        isLoadMoreItems.value = true;
        pageNo = pageNo + 1;
        pageSize = pageSize;
        getHomeNews();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
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
          categoryList:
              Utils.convertCategoriesListToJson(bookmarkNews.categories),
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
      if (await Utils.checkUserConnection()) {
        final response = await restAPI.callNewsListApi(
            categoryId: categoryId,
            locationId: locationId,
            languageId: languageId,
            pageNumber: pageNo,
            pageSize: pageSize,
            newsTypeId: 0,
            searchText: '');
        if (response.status == 200 || response.status == 201) {
          //For Testing purpose
          // if (response != null && response.newsListData.newsList.length != 0) {
          //   List<VideoList> videoList = <VideoList>[];
          //   VideoList video = VideoList(
          //       url:
          //           "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          //       type: "mp4",
          //       placeholder: "");
          //   videoList.add(video);
          //   response.newsListData.newsList[0].mediaList?.videoList = videoList;
          // }

          // Testing End

          totalCount = response.newsListData.totalCount!;
          for (int i = 0; i < response.newsListData.newsList.length; i++) {
            final bookMarkNews = await appDatabase.newsListDao
                .findNewsById(response.newsListData.newsList[i].id!);
            if (bookMarkNews != null) {
              response.newsListData.newsList[i].isBookmark = true;
            } else {
              response.newsListData.newsList[i].isBookmark = false;
            }
          }
          newsList.addAll(response.newsListData.newsList);
        } else {
          DialogUtils.errorAlert(
            context: Get.context!,
            title: 'error'.tr,
            message: response.message,
            btnText: 'ok'.tr,
            callBackFunction: () {
              Navigator.of(Get.context!).pop();
            },
          );
        }
      } else {
        DialogUtils.noInternetConnection(
          context: Get.context!,
          callBackFunction: () {},
        );
      }
    } on DioException catch (obj) {
      final res = (obj).response;
      if (res?.statusCode == 401) {
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'unauthorized_title'.tr,
          message: 'unauthorized_message'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            // Navigator.of(Get.context!).pop();
          },
        );
      } else {
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message:
              res != null ? res.data['message'] : 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            //Navigator.of(Get.context!).pop();
          },
        );
      }
      //return updateProfilleResponse;
    } on Exception catch (exception) {
      if (kDebugMode) {
        print("Got error : $exception");
      }
      try {
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message: 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            //Navigator.of(Get.context!).pop();
          },
        );
      } on Exception catch (exception) {
        final message = exception.toString();
      } catch (e) {
        print(e);
        return null;
      }
    } finally {
      isDataLoading.value = false;
      isLoadMoreItems.value = false;
    }
  }
}
