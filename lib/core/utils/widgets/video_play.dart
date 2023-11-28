import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayView extends StatefulWidget {
  const VideoPlayView({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<VideoPlayView> createState() => _VideoPlayViewState();
}

class _VideoPlayViewState extends State<VideoPlayView> {
  late VideoPlayerController _vpController;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    print("${widget.url}................................fffffffffffff");
    _vpController = VideoPlayerController.networkUrl(Uri.parse(widget.url));

    _chewieController = ChewieController(
      zoomAndPan: true,
      looping: true,
      showControlsOnInitialize: false,
      autoPlay: true,
      autoInitialize: true,
      videoPlayerController: _vpController,
      aspectRatio: 2 / 3,
    );
  }

  @override
  void dispose() {
    _vpController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          child: const CustomeLoader(),
        ),
        AspectRatio(
          aspectRatio: 2 / 3,
          child: Chewie(controller: _chewieController),
        ),
      ],
    );
  }
}
