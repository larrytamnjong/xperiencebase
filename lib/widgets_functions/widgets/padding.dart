import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

///Custom Padding Widget
class CustomPadding extends StatelessWidget {
  final Widget child;
  final double top;
  final double? left;
  final double? right;

  const CustomPadding(
      {super.key,
      required this.child,
      required this.top,
      this.left,
      this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, left: left ?? 19.4, right: right ?? 19.4),
      child: child,
    );
  }
}

///Animated List View

class AnimatedListView extends StatelessWidget {
  final int position;
  final Widget child;
  const AnimatedListView(
      {super.key, required this.position, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: position,
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
