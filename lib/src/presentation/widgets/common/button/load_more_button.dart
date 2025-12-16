import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class LoadMoreButton extends StatelessWidget {
  final bool isLoading;
  final Function onLoadMore;
  const LoadMoreButton({
    super.key,
    required this.isLoading,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.borderRadiusOfCircle),
        ),
      ),
      child: InkWellWrapper(
        onTap: () {
          if (isLoading) return;
          onLoadMore();
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.borderRadiusOfCircle),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.mediumPadding),
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                child: AnimatedBoxFade(
                  isChildVisible: !isLoading,
                  duration: const Duration(milliseconds: 200),
                  collapsedChild: const CustomLoader(size: 15, strokeWidth: 2),
                  child: Text(
                    LocaleKeys.catalogue_author_load_more.tr(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.black,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(CustomIcons.expand_circle_down),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
