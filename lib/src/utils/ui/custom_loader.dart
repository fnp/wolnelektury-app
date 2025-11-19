import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    this.color = CustomColors.black,
    this.size = 24,
    this.strokeWidth = 3,
    super.key,
  });

  final Color color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(color: color, strokeWidth: strokeWidth),
    );
  }
}
