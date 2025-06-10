import 'package:flutter/material.dart';

class AnimatedBoxSize extends StatelessWidget {
  const AnimatedBoxSize({
    required this.child,
    required this.isChildVisible,
    this.collapsedChild = const SizedBox.shrink(),
    this.duration = const Duration(milliseconds: 200),
    super.key,
  });

  final Widget child;
  final Widget collapsedChild;
  final bool isChildVisible;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: Curves.fastOutSlowIn,
      child: isChildVisible ? child : collapsedChild,
    );
  }
}
