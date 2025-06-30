import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPageCoverListenButton extends StatelessWidget {
  final BookModel book;
  final VoidCallback? onTap;
  final AudiobookModel? offlineAudiobook;
  const BookPageCoverListenButton({
    super.key,
    required this.book,
    this.offlineAudiobook,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        return ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
              ),
              BlocBuilder<DownloadCubit, DownloadState>(
                buildWhen: (p, c) =>
                    p.progress != c.progress ||
                    p.downloadingBookAudiobookSlug !=
                        c.downloadingBookAudiobookSlug,
                builder: (context, state) {
                  if (state.downloadingBookAudiobookSlug != book.slug) {
                    return const SizedBox.shrink();
                  }
                  final progressWidth =
                      availableWidth * (state.progress.clamp(0.0, 1.0));
                  return AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    left: 0,
                    top: 0,
                    bottom: 0,
                    right: availableWidth - progressWidth,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: CustomColors.green),
                    ),
                  );
                },
              ),
              BlocBuilder<DownloadCubit, DownloadState>(
                buildWhen: (p, c) {
                  return p.isDownloadingAudiobook != c.isDownloadingAudiobook ||
                      p.downloadingBookAudiobookSlug !=
                          c.downloadingBookAudiobookSlug;
                },
                builder: (context, state) {
                  return TextButtonWithIcon(
                    nonActiveColor: Colors.transparent,
                    nonActiveText: LocaleKeys.common_icon_button_listen.tr(),
                    nonActiveIcon: CustomIcons.headphones,
                    onPressed: () {
                      if (state.isDownloadingAudiobook) {
                        return;
                      }
                      if (onTap != null) {
                        onTap!();
                        return;
                      }
                      // Select proper book
                      audioCubit.pickBook(
                        book,
                        tryOffline: offlineAudiobook != null,
                      );
                      // Show audio dialog
                      AudioDialog.show(
                        context: context,
                        onClosed: () => audioCubit.dialogShown(false),
                        slug: book.slug,
                      );
                    },
                    trailing: _DownloadButton(
                      isDownloadingAudiobook: state.isDownloadingAudiobook,
                      downloadingBookAudiobookSlug:
                          state.downloadingBookAudiobookSlug,
                      book: book,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DownloadButton extends StatefulWidget {
  final bool isDownloadingAudiobook;
  final String? downloadingBookAudiobookSlug;
  final BookModel book;

  const _DownloadButton({
    required this.isDownloadingAudiobook,
    this.downloadingBookAudiobookSlug,
    required this.book,
  });

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    if (widget.isDownloadingAudiobook) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _DownloadButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDownloadingAudiobook && !_rotationController.isAnimating) {
      _rotationController.repeat();
    } else if (!widget.isDownloadingAudiobook &&
        _rotationController.isAnimating) {
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final downloaderCubit = BlocProvider.of<DownloadCubit>(context);
    final singleBookCubit = BlocProvider.of<SingleBookCubit>(context);
    final isCurrentDownload =
        widget.isDownloadingAudiobook &&
        widget.downloadingBookAudiobookSlug == widget.book.slug;

    return BlocBuilder<SingleBookCubit, SingleBookState>(
      buildWhen: (p, c) {
        return p.isAudiobookDownloaded != c.isAudiobookDownloaded ||
            p.isLoading != c.isLoading;
      },
      builder: (context, state) {
        Widget child = const SizedBox.shrink();
        if (state.isAudiobookDownloaded) {
          child = const CustomButton(
            key: ValueKey('check_button'),
            icon: Icons.check,
            backgroundColor: CustomColors.green,
            onPressed: null,
          );
        } else if (isCurrentDownload) {
          child = AnimatedBuilder(
            key: const ValueKey('rotating_button'),
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * math.pi,
                child: child,
              );
            },
            child: CustomButton(
              icon: CustomIcons.close,
              backgroundColor: CustomColors.primaryYellowColor,
              onPressed: () {
                downloaderCubit.cancelDownload();
              },
            ),
          );
        } else {
          child = CustomButton(
            key: const ValueKey('download_button'),
            icon: CustomIcons.download,
            backgroundColor: CustomColors.primaryYellowColor,
            onPressed: () {
              if (state.isLoading) return;
              downloaderCubit.downloadAudiobook(
                book: widget.book,
                onFinish: () {
                  singleBookCubit.markAudiobookAsDownloaded();
                },
              );
            },
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          ),
          child: child,
        );
      },
    );
  }
}
