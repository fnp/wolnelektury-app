import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryAudiobook extends StatelessWidget {
  final OfflineBookModel offlineBook;
  const MyLibraryAudiobook({super.key, required this.offlineBook});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OfflineCubit>(context);
    return BlocBuilder<OfflineCubit, OfflineState>(
      buildWhen: (p, c) {
        return p.books.contains(offlineBook) != c.books.contains(offlineBook);
      },
      builder: (context, state) {
        //todo handle case when book is not downloaded correctly
        print(
          'is book downlaoded correctly: ${offlineBook.isAudiobookCorrectlyDownloaded}',
        );
        final exists = state.books.contains(offlineBook);
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: exists
              ? Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.spacer),
                  child: BookPageCoverWithButtons(
                    onDelete: () {
                      cubit.removeOfflineBook(offlineBook);
                    },
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
