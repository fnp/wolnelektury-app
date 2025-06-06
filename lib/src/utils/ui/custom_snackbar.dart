import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CustomSnackbar {
  static SnackBar _getDefault({
    required String message,
    required bool isSuccess,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isSuccess ? CustomColors.green : CustomColors.red,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.largePadding),
      margin: const EdgeInsets.all(Dimensions.mediumPadding),
      elevation: 0,
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        1,
      ),
      content: SizedBox(
        height: Dimensions.elementHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        _getDefault(message: message, isSuccess: true, context: context),
      );
  }

  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        _getDefault(message: message, isSuccess: false, context: context),
      );
  }
}
