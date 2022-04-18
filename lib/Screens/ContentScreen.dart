// @dart=2.9

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Content extends StatefulWidget {
   final String src;
  const Content({Key key,  this.src}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
   VideoPlayerController _videoPlayerController;
   ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startPlayer();
  }

  Future startPlayer() async{
    _videoPlayerController = VideoPlayerController.network(
        widget.src);

    await Future.wait([_videoPlayerController.initialize()]);

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,

        showControls: false
    );

    final playerWidget = Chewie(
      controller: _chewieController,
    );

    setState(() {

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController.dispose();
    _videoPlayerController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: _chewieController != null &&
            _chewieController.videoPlayerController.value.isInitialized
            ?Stack(
              children: [
                Chewie(
          controller: _chewieController,
        ),
                Stack(

                  children: [

                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,

                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.thumb_up_sharp,color: Colors.white,size: 35,),
                            SizedBox(height: 15,),
                            Icon(Icons.thumb_down,color: Colors.white,size: 35),
                            SizedBox(height: 15,),
                            Icon(Icons.comment,color: Colors.white,size: 35),

                            SizedBox(height: 15,),
                            Icon(Icons.share,color: Colors.white,size: 35),
                            SizedBox(height: 30,),
                          ],),
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,

                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children:  [
                            CircleAvatar(
                              maxRadius: 25,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 20,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text("Aman Singh",style: TextStyle(color: Colors.white,fontSize: 25),),
                            ),
                            SizedBox(width: 10,),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () { },
                                child: Text('Follow',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],


                ),
              ],
            ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: Colors.white,),
            SizedBox(height: 10),
            Text('Loading...')
          ],
        ),
      ),
    );
  }
}
