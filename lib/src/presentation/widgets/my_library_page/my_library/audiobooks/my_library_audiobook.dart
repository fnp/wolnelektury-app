import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/audiobooks/my_library_audiobook_corrupted_dialog.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryAudiobook extends StatelessWidget {
  final OfflineBookModel offlineBook;
  const MyLibraryAudiobook({super.key, required this.offlineBook});

  @override
  Widget build(BuildContext context) {
    final downloadCubit = BlocProvider.of<DownloadCubit>(context);
    final offlineCubit = BlocProvider.of<OfflineCubit>(context);
    return BlocBuilder<OfflineCubit, OfflineState>(
      buildWhen: (p, c) {
        return p.audiobooks.contains(offlineBook) !=
                c.audiobooks.contains(offlineBook) ||
            (p.audiobookToDelete != offlineBook &&
                c.audiobookToDelete == offlineBook) ||
            (p.audiobookToDelete == offlineBook &&
                c.audiobookToDelete != offlineBook);
      },
      builder: (context, state) {
        final exists =
            state.audiobooks.contains(offlineBook) &&
            state.audiobookToDelete != offlineBook;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: exists
              ? Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.spacer),
                  child: BookPageCoverWithButtons(
                    key: ValueKey(offlineBook.isAudiobookCorrectlyDownloaded),
                    onDelete: () {
                      offlineCubit.removeOfflineAudiobook(book: offlineBook);
                      CustomSnackbar.success(
                        context,

                        LocaleKeys.my_library_offline_snackbar_audiobook_removed
                            .tr(),
                        onRevert: () {
                          offlineCubit.undoRemovingOfflineAudiobook();
                        },
                      );
                    },
                    onListen: !offlineBook.isAudiobookCorrectlyDownloaded
                        ? () {
                            MyLibraryAudiobookCorruptedDialog.show(
                              context: context,
                              onDelete: () {
                                offlineCubit.removeAudiobookInstantly(
                                  offlineBook,
                                );
                              },
                              onDownloadAgain: () {
                                downloadCubit.downloadAudiobook(
                                  book: offlineBook.book,
                                );
                              },
                            );
                          }
                        : null,
                    book: offlineBook.book,
                    offlineAudiobook: offlineBook.audiobook,
                    buttonTypes: BookButtonType.offlineAudiobook,
                  ),
                )
              : const SizedBox(width: double.infinity),
        );
      },
    );
  }
}
