import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

void changePage({
  required BuildContext context,
  required Widget page,
}) {
  Navigator.of(context).push(
    PageAnimationTransition(
      page: page,
      pageAnimationType: RightToLeftTransition(),
    ),
  );
}
