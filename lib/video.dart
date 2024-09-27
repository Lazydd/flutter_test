import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl, super.key});

  @override
  State<VideoPlayerWidget> createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  late bool isInitialized = false;

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      showControlsOnInitialize: true,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      // allowMuting: false,
      // allowFullScreen: true,
      showControls: false,
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Text("errorBuilder", style: TextStyle(color: Colors.white)),
        );
      },
    );
    isInitialized = _videoPlayerController.value.isInitialized;
    if (isInitialized) {
      _videoPlayerController.play();
    }
    setState(() {});
  }

  bool playing = true;

  void onTap() {
    if (playing) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      playing = !playing;
    });
  }

  Future<void> play() async {
    await _videoPlayerController.play();
    playing = true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isInitialized
        ? Stack(
            children: [
              Chewie(controller: _chewieController),
              if (!playing)
                const Center(
                  child: Icon(
                    Icons.add,
                    color: Color.fromRGBO(255, 255, 255, .3),
                    size: 60,
                  ),
                )
            ],
          )
        : const Center(child: CircularProgressIndicator(color: Colors.white));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
