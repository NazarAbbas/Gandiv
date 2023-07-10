import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class NewsDetailPage extends StatelessWidget {
  VideoPlayerController videoPlayerController = VideoPlayerController.network(
      'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
  late final ChewieController _chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    aspectRatio: 5 / 7,
    autoInitialize: true,
    autoPlay: false,
    looping: true,
    errorBuilder: (context, errorMessage) {
      return Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
      );
    },
  );

  NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("NewsDetailPage Page")),
        body: Container(
          width: double.infinity,
          height: 300,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
