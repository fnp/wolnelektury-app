import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class EmptyWidget extends StatelessWidget {
  final String image;
  final String message;
  final String? buttonText;
  final VoidCallback? onTap;
  final VoidCallback? onRefresh;
  final bool hasConnection;
  const EmptyWidget({
    super.key,
    required this.image,
    required this.message,
    this.buttonText,
    this.onTap,
    this.onRefresh,
    this.hasConnection = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final child = SingleChildScrollView(
      physics: onRefresh != null ? const AlwaysScrollableScrollPhysics() : null,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimary.withValues(alpha: .7),
                  BlendMode.srcIn,
                ),
                child: Image.asset(image, height: 100),
              ),
              const SizedBox(height: Dimensions.largePadding),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              if (buttonText != null && onTap != null && hasConnection) ...[
                const SizedBox(height: Dimensions.largePadding),
                ElevatedButton(
                  onPressed: onTap,
                  style: blueElevatedButton,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(buttonText!),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (onRefresh != null) {
      return RefreshIndicator.adaptive(
        onRefresh: () async {
          onRefresh!();
        },
        child: child,
      );
    }

    return child;
  }
}
