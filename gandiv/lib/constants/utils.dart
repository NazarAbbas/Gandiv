import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../models/news_list_response.dart';
import 'constant.dart';

class Utils {
  Utils(this.context);
  late BuildContext context;
  static FlutterTts ftts = FlutterTts();

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
      //await ftts.setVoice({"name": "Karen", "locale": "hi-IN"});
    } else {
      await ftts.setLanguage("en-US");
    }
    await ftts.setSpeechRate(0.5); //speed of speech
    await ftts.setVolume(1.0); //volume of speech
    await ftts.setPitch(1); //pitc of sound
    // final voices = await ftts.getVoices;

    //play text to sp
    var result = await ftts.speak(content);
    if (result == 1) {
      //speaking
    } else {
      //not speaking
    }
    await ftts.awaitSpeakCompletion(true);
  }

  void stopAudio(String content) async {
    await ftts.stop();
  }

  void loginButtonClick() {}

  static String convertImageListToJsonList(List<ImageList>? imageList) {
    return jsonEncode(imageList?.map((e) => e.toJson()).toList());
  }

  static List<ImageList> convertJsonListToImageList(String? json) {
    if (json == null || json.isEmpty) {
      List<ImageList> emptyList = <ImageList>[];
      return emptyList;
    }
    var tagsJson = jsonDecode(json) as List;
    return tagsJson.map((tagJson) => ImageList.fromJson(tagJson)).toList();
  }

  static String convertVideoListToJsonList(List<VideoList>? videoList) {
    return jsonEncode(videoList?.map((e) => e.toJson()).toList());
  }

  static List<VideoList> convertJsonListToVideoList(String? json) {
    if (json == null || json.isEmpty) {
      List<VideoList> emptyList = <VideoList>[];
      return emptyList;
    }
    var tagsJson = jsonDecode(json) as List;
    return tagsJson.map((tagJson) => VideoList.fromJson(tagJson)).toList();
  }

  static String convertAudioListToJsonList(List<AudioList>? audioList) {
    return jsonEncode(audioList?.map((e) => e.toJson()).toList());
  }

  static List<AudioList> convertJsonListToAudioList(String? json) {
    if (json == null || json.isEmpty) {
      List<AudioList> emptyList = <AudioList>[];
      return emptyList;
    }
    var tagsJson = jsonDecode(json ?? "") as List;
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
    var tagsJson = jsonDecode(categoriesList ?? "") as List;
    return tagsJson.map((tagJson) => Category.fromJson(tagJson)).toList();
  }

  static void share(NewsList news) {
    Share.share("${news.heading}\n${news.subHeading}\n${news.newsContent}");
  }

  static Future<File> genThumbnailFile(String path) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight:
          100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    File file = File(fileName!);
    return file;
  }

  static Future<String?> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory?.absolute.path;
  }

  static Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
