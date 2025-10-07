import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_download_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/audiobooks/my_library_audiobook_no_wifi_dialog.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPageCoverListenButton extends StatelessWidget {
  final BookModel book;
  final AudiobookModel? offlineAudiobook;
  // Only pass this when files are corrupted, it's flag itself
  final VoidCallback? areFilesCorruptedCallback;
  const BookPageCoverListenButton({
    super.key,
    required this.book,
    this.offlineAudiobook,
    this.areFilesCorruptedCallback,
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
                    color: theme.colorScheme.surfaceContainer,
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
                          c.downloadingBookAudiobookSlug ||
                      p.isGenericAudiobookError != c.isGenericAudiobookError;
                },
                builder: (context, state) {
                  return TextButtonWithIcon(
                    nonActiveColor: Colors.transparent,
                    nonActiveText: LocaleKeys.common_icon_button_listen.tr(),
                    nonActiveIcon: CustomIcons.headphones,
                    onPressed: () {
                      if (areFilesCorruptedCallback != null) {
                        areFilesCorruptedCallback!.call();
                        return;
                      }
                      // Select proper book
                      audioCubit.pickBook(
                        book,
                        tryOffline: offlineAudiobook != null,
                      );
                      // Show audio dialog
                      AudioDialog.show(context: context, slug: book.slug);
                    },
                    trailing: _DownloadButton(
                      isError: state.isGenericAudiobookError,
                      isDownloading: state.isDownloadingAudiobook,
                      downloadingSlug: state.downloadingBookAudiobookSlug,
                      book: book,
                      areFilesCorruptedCallback: areFilesCorruptedCallback,
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

class _DownloadButton extends StatelessWidget {
  final bool isDownloading;
  final bool isError;
  final String? downloadingSlug;
  final VoidCallback? areFilesCorruptedCallback;
  final BookModel book;
  const _DownloadButton({
    required this.isDownloading,
    required this.book,
    this.isError = false,
    this.areFilesCorruptedCallback,
    this.downloadingSlug,
  });

  @override
  Widget build(BuildContext context) {
    final downloaderCubit = BlocProvider.of<DownloadCubit>(context);
    final singleBookCubit = BlocProvider.of<SingleBookCubit>(context);
    return BlocBuilder<SingleBookCubit, SingleBookState>(
      buildWhen: (p, c) {
        return p.isAudiobookDownloaded != c.isAudiobookDownloaded ||
            p.isLoading != c.isLoading;
      },
      builder: (context, state) {
        return BookPageCoverDownloadButton(
          isError: isError,
          isDownloading: isDownloading,
          isDownloaded: state.isAudiobookDownloaded,
          isLoadingBookInfo: state.isLoading,
          downloadingSlug: downloadingSlug,
          book: book,
          areFilesCorruptedCallback: areFilesCorruptedCallback,
          onDownloadStart: () {
            final networkCubit = context.read<ConnectivityCubit>();
            final connectionType = networkCubit.state.result;

            void functionToExecute() {
              downloaderCubit.downloadAudiobook(
                book: book,
                onFinish: () {
                  singleBookCubit.markAudiobookAsDownloaded();
                },
              );
            }

            if (connectionType != ConnectivityResult.wifi) {
              MyLibraryAudiobookNoWifiDialog.show(
                context: context,
                onDownloadAnyway: () {
                  functionToExecute.call();
                },
              );
              return;
            }

            functionToExecute.call();
          },
          onDownloadCancel: () {
            downloaderCubit.cancelDownload();
          },
        );
      },
    );
  }
}
