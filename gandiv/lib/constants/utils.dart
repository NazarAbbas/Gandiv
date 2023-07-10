import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/utils.dart';

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
    await ftts.setLanguage("en-US");
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
}
