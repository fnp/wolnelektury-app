import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';

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
      switchInCurve: defaultCurve,
      switchOutCurve: defaultCurve,
      child: isChildVisible
          ? child
          : SizedBox(
              key: ValueKey(child.hashCode + collapsedChild.hashCode),
              child: collapsedChild,
            ),
    );
  }
}
