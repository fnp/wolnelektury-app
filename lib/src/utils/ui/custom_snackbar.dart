import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class CustomSnackbar {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static SnackBar _getDefault({
    required String message,
    required bool isSuccess,
    required BuildContext context,
    VoidCallback? onRevert,
    Widget? icon,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isSuccess ? CustomColors.green : CustomColors.red,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(Dimensions.mediumPadding),
      elevation: 0,
      duration: const Duration(seconds: 3),
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        1,
      ),
      content: InkWellWrapper(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: Dimensions.elementHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.smallPadding,
              horizontal: Dimensions.largePadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.mediumPadding,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.smallPadding),
                      child: icon,
                    ),
                  ),
                if (onRevert != null)
                  InkWellWrapper(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      onRevert();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.smallPadding),
                      child: Text(
                        LocaleKeys.common_snackbar_revert.tr().toUpperCase(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void success(
    BuildContext context,
    String message, {
    Widget? icon,
    VoidCallback? onTap,
    VoidCallback? onRevert,
    GlobalKey<ScaffoldMessengerState>? messengerKey,
  }) {
    (messengerKey ?? scaffoldMessengerKey).currentState!.hideCurrentSnackBar();
    (messengerKey ?? scaffoldMessengerKey).currentState!.showSnackBar(
      _getDefault(
        message: message,
        isSuccess: true,
        context: context,
        onRevert: onRevert,
        icon: icon,
        onTap: onTap,
      ),
    );
  }

  static void error(
    BuildContext context,
    String message, {
    Widget? icon,
    VoidCallback? onTap,
    GlobalKey<ScaffoldMessengerState>? messengerKey,
  }) {
    (messengerKey ?? scaffoldMessengerKey).currentState!.hideCurrentSnackBar();
    (messengerKey ?? scaffoldMessengerKey).currentState!.showSnackBar(
      _getDefault(
        message: message,
        isSuccess: false,
        context: context,
        icon: icon,
        onTap: onTap,
      ),
    );
  }
}
