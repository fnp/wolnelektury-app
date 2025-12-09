import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings_font_size.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings_font_style.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings_highlighting.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings_theme.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPageSettingsSheet extends StatelessWidget {
  final String slug;
  static const double _height = 250;
  const ReadingPageSettingsSheet({super.key, required this.slug});

  static void show({
    required BuildContext context,
    required VoidCallback onClosed,
    required String slug,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ReadingPageCubit>()),
          BlocProvider.value(value: context.read<AudioCubit>()),
        ],
        child: ReadingPageSettingsSheet(slug: slug),
      ),
    ).then((_) {
      onClosed.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: SizedBox(
        height: ReadingPageSettingsSheet._height,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.mediumPadding),
          child: Column(
            spacing: Dimensions.mediumPadding,
            children: [
              const ReadingPageSettingsSheetFontSize(),
              const ReadingPageSettingsSheetFontStyle(),
              const ReadingPageSettingsSheetTheme(),
              BlocBuilder<AudioCubit, AudioState>(
                buildWhen: (p, c) {
                  return p.isPlaying != c.isPlaying || p.book != c.book;
                },
                builder: (context, state) {
                  final disable = !state.isPlaying || state.book?.slug != slug;
                  return Opacity(
                    opacity: disable ? 0.5 : 1,
                    child: AbsorbPointer(
                      absorbing: disable,
                      child: const ReadingPageSettingsSheetHighlighting(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
