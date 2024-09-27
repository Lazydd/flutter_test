import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:test/video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: GestureDetector(
        onTap: () {
          print('onTap');
        },
        onDoubleTap: () {
          print('onDoubleTap');
        },
        child: const VideoPlayerWidget(
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        ),
      ),
    );
  }
}
