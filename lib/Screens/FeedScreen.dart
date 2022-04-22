import 'package:flutter/material.dart';
import 'package:reels/Widgets/VideoScreenWidget.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      itemCount: 10,
      controller: PageController(initialPage: 0, viewportFraction: 1),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            VideoScreenWidget(),
            buildBottomColumn(),
            rightSideColumn()
          ],
        );
      },
    ));
  }

  Align rightSideColumn() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Text("2"),
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.comment,
              color: Colors.white,
            ),
            Text("1"),
            SizedBox(
              height: 15,
            ),
            Icon(Icons.replay),
            Text("0"),
            SizedBox(
              height: 15,
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Padding buildBottomColumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Aman Singh"),
              SizedBox(
                height: 5,
              ),
              Text("No Song,Only Trip"),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Icon(Icons.music_note), Text("IDK")],
              )
            ],
          )
        ],
      ),
    );
  }
}
