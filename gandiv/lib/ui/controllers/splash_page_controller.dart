import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gandiv/constants/utils.dart';
import 'package:gandiv/database/entity/advertisement_list_db_model.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../constants/dialog_utils.dart';
import '../../database/app_database.dart';
import '../../network/rest_api.dart';
import '../../route_management/routes.dart';

class SplashPageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final AppDatabase appDatabase = Get.find<AppDatabase>();
  final player = AudioPlayer();
  var mp3FileUrl = "";
  var isLoading = false;

  @override
  void onInit() async {
    super.onInit();
    // final selectedLanguage = GetStorage();
    // selectedLanguage.write(Constant.selectedLanguage, Language.hindi);
    if (isLoading == false) {
      isLoading = true;
      await getAdvertisement();
    }
  }

  // Future<void> getLocationsApis() async {
  //   try {
  //     if (await Utils.checkUserConnection()) {
  //       final response = await restAPI.calllNewsLocations();
  //       if (response.status == 200 || response.status == 201) {
  //         await appDatabase.locationsDao.deleteLocations();
  //         // ignore: avoid_function_literals_in_foreach_calls
  //         response.data.forEach((element) async {
  //           await appDatabase.locationsDao.insertLocations(element);
  //         });
  //         getCategoriesApis();
  //       } else {
  //         DialogUtils.errorAlert(
  //           context: Get.context!,
  //           title: 'error'.tr,
  //           message: response.message,
  //           btnText: 'ok'.tr,
  //           callBackFunction: () {
  //             Navigator.of(Get.context!).pop();
  //           },
  //         );
  //       }
  //     } else {
  //       DialogUtils.noInternetConnection(
  //         context: Get.context!,
  //         callBackFunction: () {
  //           exit(0);
  //         },
  //       );
  //     }
  //   } on DioException catch (obj) {
  //     final res = (obj).response;
  //     if (res?.statusCode == 401) {
  //       DialogUtils.errorAlert(
  //         context: Get.context!,
  //         title: 'unauthorized_title'.tr,
  //         message: 'unauthorized_message'.tr,
  //         btnText: 'ok'.tr,
  //         callBackFunction: () {
  //           Navigator.of(Get.context!).pop();
  //         },
  //       );
  //     } else {
  //       DialogUtils.errorAlert(
  //         context: Get.context!,
  //         title: 'error'.tr,
  //         message:
  //             res != null ? res.data['message'] : 'something_went_wrong'.tr,
  //         btnText: 'ok'.tr,
  //         callBackFunction: () {
  //           Navigator.of(Get.context!).pop();
  //           // Navigator.of(Get.context!)
  //           //     .pushNamedAndRemoveUntil(Routes.splashPage, (route) => false);
  //         },
  //       );
  //     }
  //     //return updateProfilleResponse;
  //   } on Exception catch (exception) {
  //     if (kDebugMode) {
  //       print("Got error : $exception");
  //     }
  //     try {
  //       DialogUtils.errorAlert(
  //         context: Get.context!,
  //         title: 'error'.tr,
  //         message: 'something_went_wrong'.tr,
  //         btnText: 'ok'.tr,
  //         callBackFunction: () {
  //           Navigator.of(Get.context!).pop();
  //         },
  //       );
  //     } on Exception catch (exception) {
  //       final message = exception.toString();
  //     } catch (e) {
  //       print(e);
  //       return null;
  //     }
  //   } finally {}
  // }

  Future<void> getAdvertisement() async {
    try {
      if (await Utils.checkUserConnection()) {
        final response = await restAPI.calllAdvertisement();
        if (response.status == 200 || response.status == 201) {
          mp3FileUrl = response.advertisementData.splashUrl;
          await appDatabase.advertisementDao.deleteAdvertisementDB();
          // ignore: avoid_function_literals_in_foreach_calls
          for (int i = 0;
              i < response.advertisementData.advertisements.length;
              i++) {
            // final mediaList =
            //     response.advertisementData.advertisements[i].mediaList == null
            //         ? null
            //         : Utils.convertMediaListToJsonList(
            //             response.advertisementData.advertisements[i].mediaList);

            AdvertisementDb advertisementDB = AdvertisementDb(
                id: response.advertisementData.advertisements[i].id ?? "",
                url: response.advertisementData.advertisements[i].url ?? "",
                placeHolder:
                    response.advertisementData.advertisements[i].placeHolder ??
                        "",
                mediaList:
                    response.advertisementData.advertisements[i].mediaUrl ??
                        "");
            await appDatabase.advertisementDao
                .insertAdvertisement(advertisementDB);
          }

          getCategoriesApis();
        } else {
          isLoading = false;
          DialogUtils.errorAlert(
            context: Get.context!,
            title: 'error'.tr,
            message: response.message ?? "",
            btnText: 'ok'.tr,
            callBackFunction: () {
              exit(0);
            },
          );
        }
      } else {
        isLoading = false;
        DialogUtils.noInternetConnection(
          context: Get.context!,
          callBackFunction: () {
            exit(0);
          },
        );
      }
    } on DioException catch (obj) {
      isLoading = false;
      final res = (obj).response;
      if (res?.statusCode == 401) {
        isLoading = false;
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'unauthorized_title'.tr,
          message: 'unauthorized_message'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            exit(0);
          },
        );
      } else {
        isLoading = false;
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message:
              res != null ? res.data['message'] : 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            exit(0);
            // Navigator.of(Get.context!)
            //     .pushNamedAndRemoveUntil(Routes.splashPage, (route) => false);
          },
        );
      }
      //return updateProfilleResponse;
    } on Exception catch (exception) {
      isLoading = false;
      if (kDebugMode) {
        print("Got error : $exception");
      }
      try {
        isLoading = false;
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message: 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            exit(0);
          },
        );
      } on Exception catch (exception) {
        isLoading = false;
        final message = exception.toString();
      } catch (e) {
        isLoading = false;
        print(e);
        return null;
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getCategoriesApis() async {
    try {
      if (await Utils.checkUserConnection()) {
        final response = await restAPI.calllNewsCategories();
        if (response.status == 200 || response.status == 201) {
          await appDatabase.categoriesDao.deleteCategories();
          response.data.sort((a, b) => a.catOrder.compareTo(b.catOrder));
          response.data.removeWhere((category) => category.isActive == false);
          response.data.forEach((element) async {
            await appDatabase.categoriesDao.insertCategories(element);
          });
        } else {
          isLoading = false;
          DialogUtils.errorAlert(
            context: Get.context!,
            title: 'error'.tr,
            message: response.message,
            btnText: 'ok'.tr,
            callBackFunction: () {
              exit(0);
            },
          );
        }
      } else {
        isLoading = false;
        DialogUtils.noInternetConnection(
          context: Get.context!,
          callBackFunction: () {
            exit(0);
          },
        );
      }
    } on DioException catch (obj) {
      isLoading = false;
      final res = (obj).response;
      if (res?.statusCode == 401) {
        isLoading = false;
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'unauthorized_title'.tr,
          message: 'unauthorized_message'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            exit(0);
          },
        );
      } else {
        isLoading = false;
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message:
              res != null ? res.data['message'] : 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            exit(0);
          },
        );
      }
      //return updateProfilleResponse;
    } on Exception catch (exception) {
      isLoading = false;
      if (kDebugMode) {
        print("Got error : $exception");
      }
      try {
        isLoading = false;
        DialogUtils.errorAlert(
          context: Get.context!,
          title: 'error'.tr,
          message: 'something_went_wrong'.tr,
          btnText: 'ok'.tr,
          callBackFunction: () {
            exit(0);
          },
        );
      } on Exception catch (exception) {
        isLoading = false;
        final message = exception.toString();
      }
    } finally {
      isLoading = false;
      Timer(const Duration(seconds: 1),
          () => Get.offNamed(Routes.dashboardScreen));
      //   if (mp3FileUrl.isNotEmpty) {
      //     try {
      //       if (player.playing) {
      //         await player.stop();
      //       }
      //       await player.setAudioSource(AudioSource.uri(Uri.parse(mp3FileUrl)));
      //       await player.play();
      //       Timer(const Duration(seconds: 0),
      //           () => Get.offNamed(Routes.dashboardScreen));
      //       //await player.stop();
      //     } on Exception catch (exception) {
      //       isLoading = false;
      //       final message = exception.toString();
      //     }
      //   } else {
      //     Timer(const Duration(seconds: 1),
      //         () => Get.offNamed(Routes.dashboardScreen));
      //     // Get.toNamed(Routes.dashboardScreen);
      //   }
    }
  }
}
