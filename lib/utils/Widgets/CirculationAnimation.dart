import 'package:flutter/material.dart';

class CircularAnimation extends StatefulWidget {
  final Widget child;
  const CircularAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<CircularAnimation> createState() => _CircularAnimationState();
}

class _CircularAnimationState extends State<CircularAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    controller.forward();
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  
  

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.child,
    );
  }
}
