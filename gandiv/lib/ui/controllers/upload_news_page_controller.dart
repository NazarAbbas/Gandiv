import 'dart:io';

import 'package:dio/dio.dart' as dioError;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gandiv/models/create_news_request.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/values/app_colors.dart';
import '../../database/app_database.dart';
import '../../network/rest_api.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class UploadNewsPagePageController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  final headingController = TextEditingController();
  final subHeadingController = TextEditingController();
  final descriptionController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  final singleUserRoleValue = "Reporter".obs;

  ImagePicker imgpicker = ImagePicker();
  List<String> imageList = <String>[].obs;
  final localImagePath = "".obs;
  final networkImagePath = "".obs;
  final headingCroppedImagepath = "".obs;
  final subHeadingCroppedImagepath = "".obs;
  final contentCroppedImagepath = "".obs;
  late File imagefile;
  final AppDatabase appDatabase = Get.find<AppDatabase>();

  List<String> locationList = <String>['please_select_location'.tr].obs;
  var locationDropdownValue = 'please_select_location'.tr.obs;
  String locationDropdownSelectedID = "";

  List<String> categoriesList = <String>['please_select_category'.tr].obs;
  var categoriesDropdownValue = 'please_select_category'.tr.obs;
  String categoriesDropdownSelectedID = "";

  @override
  void onInit() async {
    super.onInit();
    final locations = await appDatabase.locationsDao.findLocations();
    for (var location in locations) {
      locationList.add(location.name!);
    }
    final categories = await appDatabase.categoriesDao.findCategories();
    for (var categorie in categories) {
      categoriesList.add(categorie.name!);
    }
  }

  void setPasswordVisible(bool isTrue) {
    isPasswordVisible.value = isTrue;
  }

  void setUserRole(String userRol) {
    singleUserRoleValue.value = userRol;
  }

  @override
  void onClose() {}

  String? isDescriptionValid() {
    if (descriptionController.text.trim().isEmpty) {
      return 'please_select_description'.tr;
    }
    return null;
  }

  String? isHeadingValid() {
    if (headingController.text.trim().isEmpty) {
      return 'please_select_heading'.tr;
    }
    return null;
  }

  String? isSubHeadingValid() {
    if (subHeadingController.text.trim().isEmpty) {
      return 'please_select_subheading'.tr;
    }
    return null;
  }

  Future<void> onUpload() async {
    await validateFields();
  }

  Future<void> validateFields() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState?.save();
      await executeNewsUploadApi();
    }
  }

  Future<void> executeNewsUploadApi() async {
    try {
      final List<http.MultipartFile> mediaFiles = <http.MultipartFile>[];

      try {
        for (int i = 0; i < imageList.length; i++) {
          var path = imageList[i];
          File imageFile = File(path);
          var stream = http.ByteStream(imageFile.openRead());
          var length = await imageFile.length();
          var multipartFile = http.MultipartFile("pictures", stream, length,
              filename: basename(imageFile.path));
          mediaFiles.add(multipartFile);
        }
      } on Exception catch (exception) {
        final message = exception;
      }

      final response = await restAPI.callCreateNewsApi(
        CreateNewsRequest(
            heading: headingController.text,
            subHeading: subHeadingController.text,
            newsContent: descriptionController.text,
            durationInMin: 0.toString(),
            locationId: locationDropdownSelectedID,
            categoryId: categoriesDropdownSelectedID,
            languageId: "2",
            status: "Created",
            multiPartFile: mediaFiles),
      );

      final res = response;
    } on dioError.DioError catch (obj) {
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
    } finally {}
  }

  void openImage(ImageSource imageSource, ImageType imageType) async {
    try {
      var pickedFile = await imgpicker.pickImage(source: imageSource);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
        imagefile = File(localImagePath.value);
        cropImage(imageType);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void openCamera(ImageType imageType) async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        localImagePath.value = pickedFile.path;
        imagefile = File(localImagePath.value);
        cropImage(imageType);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void cropImage(ImageType imageType) async {
    File? croppedfile = (await ImageCropper().cropImage(
        sourcePath: localImagePath.value,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: AppColors.colorPrimary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        )));

    if (croppedfile != null) {
      imagefile = croppedfile;
      // headingCroppedImagepath.value = croppedfile.path;
      imageList.add(croppedfile.path);
    } else {
      print("Image is not cropped.");
    }
  }
}

enum ImageType { headingImage, subHeadingImage, contentImage }
