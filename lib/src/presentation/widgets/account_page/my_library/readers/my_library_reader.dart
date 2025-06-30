import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
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
            c.readers.contains(offlineBook);
      },
      builder: (context, state) {
        final exists = state.readers.contains(offlineBook);
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: exists
              ? Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.spacer),
                  child: BookPageCoverWithButtons(
                    onDelete: () {
                      offlineCubit.removeOfflineReader(offlineBook);
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
