import 'package:flutter/material.dart';

class InkWellWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  const InkWellWrapper({
    required this.child,
    this.onTap,
    this.onLongPress,
    super.key,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashColor: splashColor,
        highlightColor: highlightColor,
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
