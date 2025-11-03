import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class CatalogueFiltering extends StatelessWidget {
  const CatalogueFiltering({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteringCubit, FilteringState>(
      buildWhen: (p, c) => p.isAnyTagSelected != c.isAnyTagSelected,
      builder: (context, state) {
        return TextButtonWithIcon(
          nonActiveText: LocaleKeys.common_icon_button_filter.tr(),
          nonActiveIcon: Icons.filter_alt,
          activeColor: CustomColors.primaryYellowColor,
          activeIcon: Icons.filter_alt,
          isActive: state.isAnyTagSelected,
          onPressed: () {
            router.pushNamed(filtersPageConfig.name);
          },
        );
      },
    );
  }
}
