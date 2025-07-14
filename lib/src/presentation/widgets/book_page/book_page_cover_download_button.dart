import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';

class BookPageCoverDownloadButton extends StatefulWidget {
  final bool isDownloading;
  final bool isDownloaded;
  final bool isError;
  final bool isLoadingBookInfo;
  final VoidCallback? areFilesCorruptedCallback;
  final String? downloadingSlug;
  final BookModel book;
  final VoidCallback? onDownloadCancel;
  final VoidCallback onDownloadStart;

  const BookPageCoverDownloadButton({
    required this.isDownloading,
    required this.isDownloaded,
    required this.isLoadingBookInfo,
    required this.book,
    required this.onDownloadStart,
    this.downloadingSlug,
    this.onDownloadCancel,
    this.areFilesCorruptedCallback,
    this.isError = false,
    super.key,
  });

  @override
  State<BookPageCoverDownloadButton> createState() =>
      BookPageCoverDownloadButtonState();
}

class BookPageCoverDownloadButtonState
    extends State<BookPageCoverDownloadButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    context.read<DownloadCubit>().resetAudiobookErrors();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    if (widget.isDownloading) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant BookPageCoverDownloadButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDownloading && !_rotationController.isAnimating) {
      _rotationController.repeat();
    } else if (!widget.isDownloading && _rotationController.isAnimating) {
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
    final isCurrentDownload =
        widget.isDownloading && widget.downloadingSlug == widget.book.slug;

    Widget child = const SizedBox.shrink();
    if (widget.isLoadingBookInfo) {
      return child;
    }
    if ((widget.areFilesCorruptedCallback != null || widget.isError) &&
        !isCurrentDownload) {
      child = CustomButton(
        key: const ValueKey('corrupted_files_button'),
        icon: CustomIcons.error,
        backgroundColor: CustomColors.red,
        iconColor: CustomColors.white,
        onPressed: () {
          if (widget.isError) {
            widget.onDownloadStart.call();
            return;
          }
          widget.areFilesCorruptedCallback?.call();
        },
      );
      return child;
    }
    if (widget.isDownloaded) {
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
          onPressed: widget.onDownloadCancel,
        ),
      );
    } else {
      child = CustomButton(
        key: const ValueKey('download_button'),
        icon: CustomIcons.download,
        backgroundColor: CustomColors.primaryYellowColor,
        onPressed: () {
          widget.onDownloadStart.call();
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
  }
}
