import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/features/readers/cubits/reader_page/reader_page_cubit.dart';
import 'package:wolnelektury/src/features/readers/widgets/settings/reader_page_settings_font_height.dart';
import 'package:wolnelektury/src/features/readers/widgets/settings/reader_page_settings_font_size.dart';
import 'package:wolnelektury/src/features/readers/widgets/settings/reader_page_settings_font_style.dart';
import 'package:wolnelektury/src/features/readers/widgets/settings/reader_page_settings_highlighting.dart';
import 'package:wolnelektury/src/features/readers/widgets/settings/reader_page_settings_theme.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReaderPageSettingsSheet extends StatelessWidget {
  final String slug;
  static const double _height = 320;
  const ReaderPageSettingsSheet({super.key, required this.slug});

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
          BlocProvider.value(value: context.read<ReaderPageCubit>()),
          BlocProvider.value(value: context.read<AudioCubit>()),
        ],
        child: ReaderPageSettingsSheet(slug: slug),
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
        height: ReaderPageSettingsSheet._height,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.mediumPadding),
          child: Column(
            spacing: Dimensions.mediumPadding,
            children: [
              const ReaderPageSettingsFontHeight(),
              const ReaderPageSettingsSheetFontSize(),
              const ReaderPageSettingsSheetFontStyle(),
              const ReaderPageSettingsSheetTheme(),
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
                      child: const ReaderPageSettingsSheetHighlighting(),
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
