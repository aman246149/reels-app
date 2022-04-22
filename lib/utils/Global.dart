import 'package:flutter/material.dart';
import 'package:reels/Screens/AddVideoScreen.dart';

List<Widget> pages = [
  // ignore: prefer_const_constructors
  Center(
    child: const Text(
      "Home",
      style: TextStyle(color: Colors.white),
    ),
  ),
  const Center(
      child: Text(
    "Search",
    style: TextStyle(color: Colors.white),
  )),
  const AddVideoScreen(),
  const Center(
      child: Text(
    "Message",
    style: TextStyle(color: Colors.white),
  )),
  const Center(
      child: Text(
    "User",
    style: TextStyle(color: Colors.white),
  ))
];
