import 'package:betta_store/presentation/helps/widgets/videoplay.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay({super.key, required this.url});
  String url;
  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController controller;
  void _playVideo({int index = 0, bool init = false}) {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: controller);
  }
}
