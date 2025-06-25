import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPageCoverListenButton extends StatelessWidget {
  final BookModel book;
  final AudiobookModel? offlineAudiobook;
  const BookPageCoverListenButton({
    super.key,
    required this.book,
    this.offlineAudiobook,
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
                    p.downloadingBookSlug != c.downloadingBookSlug,
                builder: (context, state) {
                  if (state.downloadingBookSlug != book.slug) {
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
                  return p.isDownloading != c.isDownloading ||
                      p.downloadingBookSlug != c.downloadingBookSlug;
                },
                builder: (context, state) {
                  return TextButtonWithIcon(
                    nonActiveColor: Colors.transparent,
                    nonActiveText: LocaleKeys.common_icon_button_listen.tr(),
                    nonActiveIcon: CustomIcons.headphones,
                    onPressed: () {
                      if (state.isDownloading) {
                        return;
                      }
                      // Select proper book
                      audioCubit.pickBook(
                        book,
                        offlineParts: offlineAudiobook?.parts,
                      );
                      // Show audio dialog
                      AudioDialog.show(
                        context: context,
                        onClosed: () => audioCubit.dialogShown(false),
                        slug: book.slug,
                      );
                    },
                    trailing: offlineAudiobook == null || state.isDownloading
                        ? _DownloadButton(
                            isDownloading: state.isDownloading,
                            downloadingBookSlug: state.downloadingBookSlug,
                            book: book,
                          )
                        : null,
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

class _DownloadButton extends StatelessWidget {
  final bool isDownloading;
  final String? downloadingBookSlug;
  final BookModel book;
  const _DownloadButton({
    required this.isDownloading,
    this.downloadingBookSlug,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final downloaderCubit = BlocProvider.of<DownloadCubit>(context);
    return AnimatedBoxFade(
      isChildVisible: isDownloading && downloadingBookSlug == book.slug,
      collapsedChild: CustomButton(
        icon: Icons.download,
        backgroundColor: CustomColors.green,
        onPressed: () {
          downloaderCubit.downloadAudiobook(book: book);
        },
      ),
      child: Stack(
        children: [
          const SizedBox.square(
            dimension: Dimensions.elementHeight,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.smallPadding),
              child: CustomLoader(strokeWidth: 1, color: Colors.grey),
            ),
          ),
          CustomButton(
            icon: Icons.cancel_outlined,
            backgroundColor: Colors.transparent,
            onPressed: () {
              downloaderCubit.cancelDownload();
            },
          ),
        ],
      ),
    );
  }
}
