import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../constants/dialog_utils.dart';
import '../../constants/utils.dart';
import '../../database/app_database.dart';
import '../../models/news_list_db_model.dart';
import '../../models/news_list_response.dart';
import '../../network/rest_api.dart';

class SearchPageController extends GetxController {
  var isListening = false.obs;
  var speechTextHint = 'search_here'.tr.obs;
  var confidence = 1.0.obs;
  late SpeechToText speechToText;
  final searchController = TextEditingController();
  final focusNode = FocusNode().obs;

  final RestAPI restAPI = Get.find<RestAPI>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  ScrollController controller = ScrollController();
  int pageNo = 1;
  int pageSize = 5;
  int totalCount = 0;

  List<NewsList> newsList = <NewsList>[].obs;
  var isDataLoading = false.obs;
  var isLoadMoreItems = false.obs;
  var locationId = '';
  var categoryId = '';
  int languageId = 0;

  @override
  void onInit() async {
    super.onInit();
    isDataLoading.value = true;
    speechToText = SpeechToText();
    if (newsList.isNotEmpty) {
      for (int i = 0; i < newsList.length; i++) {
        final bookMarkNews =
            await appDatabase.newsListDao.findNewsById(newsList[i].id!);
        if (bookMarkNews != null) {
          newsList[i].isBookmark = true;
          newsList[i] = newsList[i];
        } else {
          newsList[i].isBookmark = false;
          newsList[i] = newsList[i];
        }
        isDataLoading.value = false;
        isLoadMoreItems.value = false;
      }
    } else {
      // final location = await appDatabase.locationsDao
      //     .findLocationsIdByName(GetStorage().read(Constant.selectedLocation));
      // final category = await appDatabase.categoriesDao
      //     .findCategoriesIdByName('International');
      // locationId = location!.id!;
      // categoryId = category!.id!;
      // languageId = GetStorage().read(Constant.selectedLanguage);
      // pageNo = 1;
      // pageSize = 5;
      // newsList.clear();
      // await callSearchApi();
    }
  }

  @override
  void onReady() {
    super.onReady();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels &&
          totalCount > newsList.length) {
        isLoadMoreItems.value = true;
        // await Future.delayed(const Duration(seconds: 2));
        pageNo = pageNo + 1;
        pageSize = pageSize;
        callSearchApi();
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

  Future<void> callSearchApi() async {
    try {
      if (await Utils.checkUserConnection()) {
        final response = await restAPI.callNewsListApi(
            categoryId: '',
            locationId: '',
            languageId: languageId,
            pageNumber: pageNo,
            pageSize: pageSize,
            newsTypeId: 0,
            searchText: searchController.text);
        if (response.status == 200 || response.status == 201) {
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
        if (kDebugMode) {
          print(e);
        }
      }
    } finally {
      isDataLoading.value = false;
      isLoadMoreItems.value = false;
    }
  }

  void listen(BuildContext context) async {
    if (!isListening.value) {
      bool avail =
          await speechToText.initialize(onStatus: (val) {}, onError: (val) {});
      if (avail) {
        isListening.value = true;
        speechToText.listen(onResult: (value) {
          searchController.text = value.recognizedWords;
          if (value.hasConfidenceRating && value.confidence > 0) {
            // if (value.hasConfidenceRating) {
            confidence.value = value.confidence;
            isListening.value = false;
            speechToText.stop();
            //FocusScope.of(context).requestFocus(focusNode.value);
            newsList.clear();
            callSearchApi();
          }
        });
      }
    } else {
      isListening.value = false;
      speechToText.stop();
    }
  }
}
