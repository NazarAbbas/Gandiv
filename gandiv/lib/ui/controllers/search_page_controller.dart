import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchPageController extends GetxController {
  var isListening = false.obs;
  var speechTextHint = 'search here...'.obs;
  var confidence = 1.0.obs;
  late SpeechToText speechToText;
  final searchController = TextEditingController();
  final focusNode = FocusNode().obs;

  @override
  void onInit() {
    super.onInit();
    speechToText = SpeechToText();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void callSearchApi() async {
    final xx = await "";
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
            confidence.value = value.confidence;
            isListening.value = false;
            speechToText.stop();
            FocusScope.of(context).requestFocus(focusNode.value);
          }
        });
      }
    } else {
      isListening.value = false;
      speechToText.stop();
    }
  }
}
