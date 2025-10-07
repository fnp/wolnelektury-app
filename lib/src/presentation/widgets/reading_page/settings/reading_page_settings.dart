import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings_font_size.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings_font_style.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings_theme.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPageSettings extends StatelessWidget {
  static const double _height = 200;
  const ReadingPageSettings({super.key});

  static void show({
    required BuildContext context,
    required VoidCallback onClosed,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      // backgroundColor: CustomColors.primaryYellowColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<ReadingPageCubit>(),
        child: const ReadingPageSettings(),
      ),
    ).then((_) {
      onClosed.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: ReadingPageSettings._height,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.mediumPadding),
        child: Column(
          spacing: Dimensions.mediumPadding,
          children: [
            ReadingPageSettingsFontSize(),
            ReadingPageSettingsFontStyle(),
            ReadingPageSettingsTheme(),
          ],
        ),
      ),
    );
  }
}
