import 'package:flutter/material.dart';

customSnackBar(String content, BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(content)));
}
