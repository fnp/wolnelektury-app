import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class SponsorsBottomSheet extends StatelessWidget {
  const SponsorsBottomSheet({super.key});

  static void show({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (_) => const SponsorsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      bottom: true,
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: Dimensions.veryLargePadding,
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.mediumPadding),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      spacing: Dimensions.veryLargePadding,
                      children: [
                        Expanded(
                          child: SvgPicture.asset(
                            Images.mkidn,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        Expanded(
                          child: SvgPicture.asset(
                            Images.pfron,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                spacing: Dimensions.veryLargePadding,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.login_info_mkidn.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.login_info_pfron.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.spacer),
            ],
          ),
        ),
      ),
    );
  }
}
