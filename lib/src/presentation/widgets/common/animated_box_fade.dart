import 'package:flutter/material.dart';

class AnimatedBoxFade extends StatelessWidget {
  const AnimatedBoxFade({
    required this.child,
    this.collapsedChild = const SizedBox.shrink(),
    required this.isChildVisible,
    this.duration = const Duration(milliseconds: 200),
    super.key,
  });

  final Widget child;
  final Widget collapsedChild;
  final bool isChildVisible;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastOutSlowIn,
      child: isChildVisible
          ? child
          : SizedBox(
              child: collapsedChild,
            ),
    );
  }
}
