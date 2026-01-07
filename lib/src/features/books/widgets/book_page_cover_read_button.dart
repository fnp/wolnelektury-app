import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_cover_download_button.dart';
import 'package:wolnelektury/src/features/common/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPageCoverReadButton extends StatelessWidget {
  final BookModel book;
  final ReaderBookModel? offlineReader;
  const BookPageCoverReadButton({
    super.key,
    required this.book,
    this.offlineReader,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            buildWhen: (p, c) {
              return p.isDownloadingReader != c.isDownloadingReader ||
                  p.downloadingBookReaderSlug != c.downloadingBookReaderSlug;
            },
            builder: (context, state) {
              return TextButtonWithIcon(
                nonActiveColor: Colors.transparent,
                nonActiveText: LocaleKeys.common_icon_button_read.tr(),
                nonActiveIcon: CustomIcons.book_5,
                onPressed: () {
                  if (state.isDownloadingReader) {
                    return;
                  }
                  router.pushNamed(
                    readingPageConfig.name,
                    pathParameters: {'slug': book.slug},
                    extra: book,
                  );
                },
                trailing: _DownloadButton(
                  isDownloading: state.isDownloadingReader,
                  downloadingSlug: state.downloadingBookReaderSlug,
                  book: book,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  final bool isDownloading;
  final String? downloadingSlug;
  final BookModel book;
  const _DownloadButton({
    required this.isDownloading,
    required this.book,
    this.downloadingSlug,
  });

  @override
  Widget build(BuildContext context) {
    final downloaderCubit = BlocProvider.of<DownloadCubit>(context);
    final singleBookCubit = BlocProvider.of<SingleBookCubit>(context);
    return BlocBuilder<SingleBookCubit, SingleBookState>(
      buildWhen: (p, c) {
        return p.isReaderDownloaded != c.isReaderDownloaded ||
            p.isLoading != c.isLoading;
      },
      builder: (context, state) {
        return BookPageCoverDownloadButton(
          isDownloading: isDownloading,
          isDownloaded: state.isReaderDownloaded,
          isLoadingBookInfo: state.isLoading,
          downloadingSlug: downloadingSlug,
          book: book,
          onDownloadStart: () {
            downloaderCubit.saveReader(
              book: book,
              onFinish: () {
                singleBookCubit.markReaderAsDownloaded();
              },
            );
          },
        );
      },
    );
  }
}
