import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
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
                color: theme.colorScheme.secondaryContainer,
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
                  isDownloadingReader: state.isDownloadingReader,
                  downloadingBookReaderSlug: state.downloadingBookReaderSlug,
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

class _DownloadButton extends StatefulWidget {
  final bool isDownloadingReader;
  final String? downloadingBookReaderSlug;
  final BookModel book;

  const _DownloadButton({
    required this.isDownloadingReader,
    this.downloadingBookReaderSlug,
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
    if (widget.isDownloadingReader) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _DownloadButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDownloadingReader && !_rotationController.isAnimating) {
      _rotationController.repeat();
    } else if (!widget.isDownloadingReader && _rotationController.isAnimating) {
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
        widget.isDownloadingReader &&
        widget.downloadingBookReaderSlug == widget.book.slug;

    return BlocBuilder<SingleBookCubit, SingleBookState>(
      buildWhen: (p, c) {
        return p.isReaderDownloaded != c.isReaderDownloaded ||
            p.isLoading != c.isLoading;
      },
      builder: (context, state) {
        Widget child = const SizedBox.shrink();
        if (state.isReaderDownloaded) {
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
              onPressed: () {},
            ),
          );
        } else {
          child = CustomButton(
            key: const ValueKey('download_button'),
            icon: CustomIcons.download,
            backgroundColor: CustomColors.primaryYellowColor,
            onPressed: () {
              if (state.isLoading) return;
              downloaderCubit.saveReader(
                book: widget.book,
                onFinish: () {
                  singleBookCubit.markReaderAsDownloaded();
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
