import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreenWidget extends StatefulWidget {
  const VideoScreenWidget({Key? key}) : super(key: key);

  @override
  State<VideoScreenWidget> createState() => _VideoScreenWidgetState();
}

class _VideoScreenWidgetState extends State<VideoScreenWidget> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        "https://assets.mixkit.co/videos/preview/mixkit-going-down-a-curved-highway-down-a-mountain-41576-large.mp4")
      ..initialize().then((value) => {
            _videoPlayerController.play(),
            _videoPlayerController.setVolume(1),
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: VideoPlayer(_videoPlayerController),
    );
  }
}
