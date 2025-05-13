import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated_box_size.dart';
import 'package:wolnelektury/src/presentation/widgets/donation/donation_dialog.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DashboardBottomBar extends StatelessWidget {
  const DashboardBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RouterCubit, RouterState>(
      buildWhen: (p, c) => p.isMainPage != c.isMainPage,
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: AnimatedBoxSize(
            isChildVisible: state.isMainPage,
            child: Material(
              child: Ink(
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiaryContainer,
                  border: Border(
                    top: BorderSide(
                      color: theme.colorScheme.surface,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.smallPadding,
                    ),
                    child: SizedBox(
                      height: Dimensions.bottomBarHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _NavigationItem(
                            onTap: () {
                              router.goNamed(cataloguePageConfig.name);
                            },
                            shouldCorrectPadding: true,
                            path: cataloguePageConfig.path,
                            icon: CustomIcons.globe_book,
                            text: LocaleKeys.dashboard_catalogue.tr(),
                          ),
                          _NavigationItem(
                            onTap: () {
                              //TODO Should navigate to dono page when logged in
                              DonationDialog.show(context);
                            },
                            icon: CustomIcons.savings,
                            text: LocaleKeys.dashboard_donation.tr(),
                          ),
                          _NavigationItem(
                            onTap: () {
                              router.goNamed(lastReadPageConfig.name);
                            },
                            path: lastReadPageConfig.path,
                            icon: CustomIcons.import_contacts,
                            text: LocaleKeys.dashboard_last_read.tr(),
                          ),
                          _NavigationItem(
                            onTap: () {
                              router.goNamed(accountPageConfig.name);
                            },
                            shouldCorrectPadding: true,
                            path: accountPageConfig.path,
                            icon: CustomIcons.for_you,
                            text: LocaleKeys.dashboard_account_logged.tr(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.onTap,
    required this.icon,
    required this.text,
    this.path,
    this.shouldCorrectPadding = false,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String text;
  final String? path;
  final bool shouldCorrectPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<RouterCubit, RouterState>(
      buildWhen: (p, c) =>
          p.location == path && c.location != path ||
          p.location != path && c.location == path,
      builder: (context, state) {
        return Expanded(
          child: InkWell(
            splashColor: theme.colorScheme.surface,
            highlightColor: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(Dimensions.smallBorderRadius),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.largePadding),
                  Padding(
                    padding: shouldCorrectPadding
                        ? const EdgeInsets.only(right: 1)
                        : EdgeInsets.zero,
                    child: Icon(
                      icon,
                      size: 24,
                      color: state.location == path
                          ? CustomColors.secondaryBlueColor
                          : theme.colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const SizedBox(height: Dimensions.smallPadding),
                  Text(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFeatures: [const FontFeature.enable('smcp')],
                      fontWeight: FontWeight.bold,
                      height: 1.09,
                      fontSize: 11,
                      color: state.location == path
                          ? CustomColors.secondaryBlueColor
                          : theme.colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
