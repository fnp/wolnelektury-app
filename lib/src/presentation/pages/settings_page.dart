import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_header.dart';
import 'package:wolnelektury/src/presentation/widgets/settings_page/theme_toggle_switch.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final switchValue = useState(true);
    return Padding(
      padding: const EdgeInsets.all(
        Dimensions.mediumPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: LocaleKeys.settings_title.tr(),
          ),
          const SizedBox(
            height: Dimensions.spacer,
          ),
          _SettingsContainer(
            text: LocaleKeys.settings_notifications.tr(),
            padding: const EdgeInsets.only(
              left: Dimensions.veryLargePadding,
            ),
            child: FlutterSwitch(
              activeColor: CustomColors.green,
              inactiveColor: CustomColors.red,
              height: 38,
              toggleSize: 30,
              width: 80,
              padding: 5,
              value: switchValue.value,
              onToggle: (v) {
                switchValue.value = v;
              },
            ),
          ),
          _SettingsContainer(
            text: LocaleKeys.settings_theme.tr(),
            padding: const EdgeInsets.only(
              left: Dimensions.veryLargePadding,
            ),
            child: ThemeToggleSwitch(
              initialMode: BlocProvider.of<SettingsCubit>(context).state.theme,
            ),
          ),
          _SettingsContainer(
            text: LocaleKeys.settings_change_password.tr(),
          ),
          _SettingsContainer(
            text: LocaleKeys.settings_rate.tr(),
          ),
          _SettingsContainer(
            text: LocaleKeys.settings_delete.tr(),
          ),
          const SizedBox(height: Dimensions.mediumPadding),
          Row(
            children: [
              const Spacer(),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logout();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    LocaleKeys.settings_logout.tr(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.largePadding),
        ],
      ),
    );
  }
}

class _SettingsContainer extends StatelessWidget {
  const _SettingsContainer({
    required this.text,
    this.padding = const EdgeInsets.only(
      left: Dimensions.veryLargePadding,
      right: Dimensions.mediumPadding,
    ),
    this.child,
  });

  final String text;
  final Widget? child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.mediumPadding,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(
            Dimensions.borderRadiusOfCircle,
          ),
          border: Border.all(
            color: theme.colorScheme.surface,
          ),
        ),
        child: Padding(
          padding: padding,
          child: SizedBox(
            height: Dimensions.elementHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.black,
                    ),
                  ),
                ),
                child ??
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: CustomColors.black,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
