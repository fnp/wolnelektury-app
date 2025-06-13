import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_book_cover.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_bookmarks/audio_dialog_bookmarks.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_controls.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_settings/audio_dialog_settings.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_slider.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_top_bar.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialog extends StatelessWidget {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  const AudioDialog({super.key});

  static void show({
    required BuildContext context,
    required VoidCallback onClosed,
    required String slug,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ScrollCubit>()),
            BlocProvider.value(
              value: context.read<AudioCubit>()
                ..dialogShown(true)
                ..toggleBookmarks(false),
            ),
            BlocProvider(
              create: (context) {
                return BookmarksCubit(get.get())..getBookBookmarks(slug: slug);
              },
            ),
          ],
          child: ScaffoldMessenger(
            key: messengerKey,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Builder(
                builder: (context) {
                  final audioCubit = BlocProvider.of<AudioCubit>(context);
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: BlocBuilder<AudioCubit, AudioState>(
                          buildWhen: (p, c) =>
                              p.isSettingsOpened != c.isSettingsOpened ||
                              p.isPreparingPlaylist != c.isPreparingPlaylist ||
                              p.isBookmarksOpened != c.isBookmarksOpened,
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                if (state.isSettingsOpened) {
                                  audioCubit.toggleSettings(false);
                                  return;
                                }
                                if (state.isBookmarksOpened) {
                                  audioCubit.toggleBookmarks(false);
                                  return;
                                }

                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      ),
                      const AudioDialog(),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    ).then((_) {
      onClosed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      buildWhen: (p, c) => p.isPreparingPlaylist != c.isPreparingPlaylist,
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
                vertical: Dimensions.mediumPadding,
              ),
              backgroundColor: CustomColors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Dimensions.modalsBorderRadius,
                ),
              ),
              child: BlocBuilder<AudioCubit, AudioState>(
                buildWhen: (p, c) {
                  return p.book != c.book ||
                      p.isLoadingAudiobook != c.isLoadingAudiobook;
                },
                builder: (context, state) {
                  if (state.book == null) {
                    //todo error screen
                    return const Center(child: Text('Error'));
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimensions.modalsBorderRadius,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.mediumPadding,
                            horizontal: Dimensions.mediumPadding,
                          ),
                          child: Column(
                            spacing: Dimensions.spacer,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const AudioDialogTopBar(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.modalsPadding,
                                ),
                                child: Center(
                                  child: AudioDialogBookCover(
                                    bookCoverUrl: state.book!.coverUrl,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.fastOutSlowIn,
                                  child: Column(
                                    spacing: Dimensions.spacer,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (state.isLoadingAudiobook) ...[
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: Dimensions.spacer,
                                            ),
                                            child: CustomLoader(
                                              color: CustomColors
                                                  .secondaryBlueColor,
                                            ),
                                          ),
                                        ),
                                      ] else ...[
                                        AudioDialogSlider(book: state.book!),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.modalsPadding -
                                                Dimensions.smallPadding * 2,
                                          ),
                                          child: AudioDialogControls(),
                                        ),
                                        const SizedBox(
                                          height: Dimensions.spacer,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const _GrayCover(),
                        const _Bookmarks(),
                        const _Settings(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Settings extends StatelessWidget {
  const _Settings();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      buildWhen: (p, c) => p.isSettingsOpened != c.isSettingsOpened,
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          left: 0,
          right: 0,
          top: state.isSettingsOpened
              ? 0
              : -(MediaQuery.sizeOf(context).height / 3),
          child: const AudioDialogSettings(),
        );
      },
    );
  }
}

class _Bookmarks extends StatelessWidget {
  const _Bookmarks();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      buildWhen: (p, c) => p.isBookmarksOpened != c.isBookmarksOpened,
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          left: 0,
          right: 0,
          top: state.isBookmarksOpened
              ? 0
              : -(MediaQuery.sizeOf(context).height * 0.66),
          child: const AudioDialogBookmarks(),
        );
      },
    );
  }
}

class _GrayCover extends StatelessWidget {
  const _GrayCover();

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return BlocBuilder<AudioCubit, AudioState>(
      buildWhen: (p, c) =>
          p.isSettingsOpened != c.isSettingsOpened ||
          p.isBookmarksOpened != c.isBookmarksOpened,
      builder: (context, state) {
        return Positioned.fill(
          child: GestureDetector(
            onTap: () {
              audioCubit.toggleSettings(false);
              audioCubit.toggleBookmarks(false);
            },
            child: AnimatedBoxFade(
              isChildVisible: state.isSettingsOpened || state.isBookmarksOpened,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: CustomColors.darkGrey.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(
                    Dimensions.modalsBorderRadius,
                  ),
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        );
      },
    );
  }
}
