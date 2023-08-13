import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:get_storage/get_storage.dart';
import '../models/news_list_response.dart';
import 'constant.dart';

class Utils {
  Utils(this.context);
  late BuildContext context;
  FlutterTts ftts = FlutterTts();

  Future<void> startLoading() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          elevation: 0.0,
          backgroundColor:
              Colors.transparent, // can change this to your prefered color
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }

  void showDiaolg(
      String title,
      String message,
      String btnOkText,
      String btnCancelText,
      final VoidCallback okButtonPress,
      VoidCallback cancelButtonPress) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: message,
      btnCancelText: btnCancelText,
      btnOkText: btnOkText,
      btnCancelOnPress: () {
        cancelButtonPress.call();
      },
      btnOkOnPress: () {
        okButtonPress.call();
      },
    ).show();
  }

  void startAudio(String content) async {
    final languageId = GetStorage().read(Constant.selectedLanguage);
    if (languageId == 1) {
      await ftts.setLanguage("hi");
    } else {
      await ftts.setLanguage("en-US");
    }
    await ftts.setSpeechRate(0.5); //speed of speech
    await ftts.setVolume(1.0); //volume of speech
    await ftts.setPitch(1); //pitc of sound
    //play text to sp
    var result = await ftts.speak(content);
    if (result == 1) {
      //speaking
    } else {
      //not speaking
    }
  }

  void stopAudio(String content) async {
    await ftts.stop();
  }

  void loginButtonClick() {}

  static String convertImageListToJsonList(List<ImageList>? imageList) {
    return jsonEncode(imageList?.map((e) => e.toJson()).toList());
  }

  static List<ImageList> convertJsonListToImageList(String? json) {
    var tagsJson = jsonDecode(json!) as List;
    return tagsJson.map((tagJson) => ImageList.fromJson(tagJson)).toList();
  }

  static String convertVideoListToJsonList(List<VideoList>? videoList) {
    return jsonEncode(videoList?.map((e) => e.toJson()).toList());
  }

  static List<VideoList> convertJsonListToVideoList(String? json) {
    var tagsJson = jsonDecode(json!) as List;
    return tagsJson.map((tagJson) => VideoList.fromJson(tagJson)).toList();
  }

  static String convertAudioListToJsonList(List<AudioList>? audioList) {
    return jsonEncode(audioList?.map((e) => e.toJson()).toList());
  }

  static List<AudioList> convertJsonListToAudioList(String? json) {
    var tagsJson = jsonDecode(json!) as List;
    return tagsJson.map((tagJson) => AudioList.fromJson(tagJson)).toList();
  }

  static String convertToJsonObject(NewsList newsList) {
    return json.encode(newsList.toJson());
  }

  static NewsList convertToObject(String json) {
    return NewsList.fromRawJson(json);
  }

  static String? convertCategoriesListToJson(List<Category>? categoriesList) {
    return jsonEncode(categoriesList?.map((e) => e.toJson()).toList());
  }

  static List<Category>? convertStringToCategoriesList(String? categoriesList) {
    var tagsJson = jsonDecode(categoriesList!) as List;
    return tagsJson.map((tagJson) => Category.fromJson(tagJson)).toList();
  }
}
