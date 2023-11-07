import 'package:flutter_tts/flutter_tts.dart';

class TtsUtills {
  static FlutterTts ftts = FlutterTts();
  static void startAudio(String content) async {
    // final languageId = GetStorage().read(Constant.selectedLanguage);
    // if (languageId == 1) {
    //   await ftts.setLanguage("hi");
    //   //await ftts.setVoice({"name": "Karen", "locale": "hi-IN"});
    // } else {
    //   await ftts.setLanguage("en-US");
    // }
    await ftts.setLanguage("hi");
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

  static void stopAudio() async {
    await ftts.stop();
  }
}
