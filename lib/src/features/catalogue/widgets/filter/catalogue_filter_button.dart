import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/features/catalogue/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CatalogueFilterButton extends StatelessWidget {
  const CatalogueFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteringCubit, FilteringState>(
      buildWhen: (p, c) {
        return p.isAnyTagSelected != c.isAnyTagSelected ||
            p.selectedTags.length != c.selectedTags.length;
      },
      builder: (context, state) {
        return TextButtonWithIcon(
          nonActiveText: LocaleKeys.common_icon_button_filter.tr(),
          nonActiveIcon: Icons.filter_alt,
          activeColor: CustomColors.primaryYellowColor,
          activeIcon: Icons.filter_alt,
          isActive: state.isAnyTagSelected,
          trailing: _getTrailing(state.selectedTags.length, context),
          onPressed: () {
            router.pushNamed(filtersPageConfig.name);
          },
        );
      },
    );
  }

  Widget? _getTrailing(int count, BuildContext context) {
    if (count == 0) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.mediumPadding),
      child: SizedBox(
        width: Dimensions.elementHeight / 1.5,
        height: Dimensions.elementHeight / 1.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadiusOfCircle,
            ),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                count.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CustomColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
