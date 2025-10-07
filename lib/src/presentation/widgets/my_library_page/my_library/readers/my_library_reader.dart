import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryReader extends StatelessWidget {
  final OfflineBookModel offlineBook;
  const MyLibraryReader({super.key, required this.offlineBook});

  @override
  Widget build(BuildContext context) {
    final offlineCubit = BlocProvider.of<OfflineCubit>(context);
    return BlocBuilder<OfflineCubit, OfflineState>(
      buildWhen: (p, c) {
        return p.readers.contains(offlineBook) !=
                c.readers.contains(offlineBook) ||
            (p.readerToDelete?.book.slug != offlineBook.book.slug &&
                c.readerToDelete?.book.slug == offlineBook.book.slug) ||
            (p.readerToDelete?.book.slug == offlineBook.book.slug &&
                c.readerToDelete?.book.slug != offlineBook.book.slug);
      },
      builder: (context, state) {
        final exists =
            state.readers.contains(offlineBook) &&
            state.readerToDelete?.book.slug != offlineBook.book.slug;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          child: exists
              ? Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.spacer),
                  child: BookPageCoverWithButtons(
                    onDelete: () {
                      offlineCubit.removeOfflineReader(book: offlineBook);
                      CustomSnackbar.success(
                        context,
                        LocaleKeys.my_library_offline_snackbar_reader_removed
                            .tr(),
                        onRevert: () {
                          offlineCubit.undoRemovingOfflineReader();
                        },
                      );
                    },
                    book: offlineBook.book,
                    offlineReader: offlineBook.reader,
                    buttonTypes: BookButtonType.offlineReader,
                  ),
                )
              : const SizedBox(width: double.infinity),
        );
      },
    );
  }
}
