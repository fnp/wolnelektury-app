import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/features/readers/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPageSettingsSheetHighlighting extends StatelessWidget {
  const ReadingPageSettingsSheetHighlighting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: Dimensions.elementHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.veryLargePadding,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.reader_settings_text_sync.tr(),
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<ReadingPageCubit, ReadingPageState>(
              buildWhen: (p, c) =>
                  p.isEnabledHighlighting != c.isEnabledHighlighting,
              builder: (context, state) {
                return FlutterSwitch(
                  activeColor: CustomColors.green,
                  inactiveColor: CustomColors.darkModeGrey,
                  height: 38,
                  toggleSize: 30,
                  width: 80,
                  padding: 5,
                  value: state.isEnabledHighlighting,
                  onToggle: (value) {
                    context.read<ReadingPageCubit>().enableHighlighting(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
