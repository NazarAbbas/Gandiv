import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerPageController extends FullLifeCycleController {
  var isDataLoading = false.obs;
  final player = AudioPlayer().obs;
  @override
  void onInit() async {
    super.onInit();
    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // AudioPlayerPageController audioPlayerPageController =
    //     Get.find<AudioPlayerPageController>();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    // ));
    // _init();
  }

  // Future<void> _init() async {
  //   final session = await AudioSession.instance;
  //   await session.configure(const AudioSessionConfiguration.speech());
  //   player.value.playbackEventStream.listen((event) {},
  //       onError: (Object e, StackTrace stackTrace) {
  //     print('A stream error occurred: $e');
  //   });
  //   try {
  //     await player.value.setAudioSource(AudioSource.uri(Uri.parse(
  //         "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
  //   } catch (e) {
  //     print("Error loading audio source: $e");
  //   }
  //   player.value.play();
  // }
}
