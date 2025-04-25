import 'package:flutter/material.dart';

class AnimatedBoxSize extends StatelessWidget {
  const AnimatedBoxSize({
    required this.child,
    this.collapsedChild = const SizedBox.shrink(),
    required this.isChildVisible,
    super.key,
  });

  final Widget child;
  final Widget collapsedChild;
  final bool isChildVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      child: isChildVisible ? child : collapsedChild,
    );
  }
}
