import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:reels/utils/Global.dart';
import 'package:reels/utils/Widgets/CustomIcon.dart';
import 'package:reels/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller;
  int initalPage = 0;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        onTap: ((value) {
          _controller.jumpToPage(value);
        }),
        backgroundColor: mobileBackgroundColor,
        activeColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: initalPage == 0 ? Colors.red : Colors.white,
              ),
              backgroundColor: mobileBackgroundColor,
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: initalPage == 1 ? Colors.red : Colors.white,
              ),
              backgroundColor: mobileBackgroundColor,
              label: ""),
          const BottomNavigationBarItem(
              icon: CustomIcon(),
              backgroundColor: mobileBackgroundColor,
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: initalPage == 3 ? Colors.red : Colors.white,
              ),
              backgroundColor: mobileBackgroundColor,
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: initalPage == 4 ? Colors.red : Colors.white,
              ),
              backgroundColor: mobileBackgroundColor,
              label: ""),
        ],
      ),
      body: PageView(
        children: pages,
        controller: _controller,
        onPageChanged: (int page) {
          setState(() {
            initalPage = page;
          });
        },
      ),
    );
  }
}
