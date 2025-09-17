import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/likes/likes_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_listen_button.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_read_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

enum BookButtonType { all, offlineAudiobook, offlineReader }

class BookPageCoverWithButtons extends StatelessWidget {
  final BookModel book;
  final AudiobookModel? offlineAudiobook;
  final ReaderBookModel? offlineReader;
  final VoidCallback? onDelete;
  final VoidCallback? areFilesCorruptedCallback;
  final BookButtonType buttonTypes;
  const BookPageCoverWithButtons({
    super.key,
    required this.book,
    this.buttonTypes = BookButtonType.all,
    this.offlineAudiobook,
    this.offlineReader,
    this.onDelete,
    this.areFilesCorruptedCallback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth / 2;
        final usableWidth = availableWidth - (Dimensions.mediumPadding / 2);
        return SizedBox(
          height: usableWidth / Dimensions.coverAspectRatio,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _Image(coverUrl: book.coverUrl),
                    if (offlineAudiobook != null)
                      Positioned(
                        left: Dimensions.mediumPadding,
                        bottom: Dimensions.mediumPadding,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions.smallBorderRadius),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              Dimensions.smallPadding,
                            ),
                            child: Row(
                              spacing: Dimensions.smallPadding,
                              children: [
                                const Icon(Icons.sd_storage_outlined, size: 16),
                                Text(
                                  '${offlineAudiobook!.totalSizeInMB.toStringAsFixed(0)} MB',
                                  style: theme.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: Dimensions.mediumPadding),
              Expanded(
                child: BlocProvider(
                  create: (context) {
                    return SingleBookCubit(get.get(), get.get())
                      ..checkIfMediaAreDownloaded(book.slug);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: onDelete == null
                            ? _TitleWithAuthors(book: book)
                            : _TitleWithAutorsAndDelete(
                                book: book,
                                onDelete: onDelete!,
                              ),
                      ),
                      if (buttonTypes == BookButtonType.all ||
                          buttonTypes == BookButtonType.offlineReader)
                        BookPageCoverReadButton(
                          book: book,
                          offlineReader: offlineReader,
                        ),
                      if (book.hasAudiobook &&
                              buttonTypes != BookButtonType.offlineReader ||
                          buttonTypes == BookButtonType.offlineAudiobook) ...[
                        const SizedBox(height: Dimensions.mediumPadding),
                        BookPageCoverListenButton(
                          book: book,
                          offlineAudiobook: offlineAudiobook,
                          areFilesCorruptedCallback: areFilesCorruptedCallback,
                        ),
                      ],
                      if (buttonTypes == BookButtonType.all) ...[
                        const SizedBox(height: Dimensions.mediumPadding),
                        _HeartButton(book: book),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TitleWithAutorsAndDelete extends StatelessWidget {
  final BookModel book;
  final VoidCallback onDelete;
  const _TitleWithAutorsAndDelete({required this.book, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _TitleWithAuthors(book: book)),
        BlocBuilder<DownloadCubit, DownloadState>(
          buildWhen: (p, c) {
            return p.downloadingBookAudiobookSlug !=
                c.downloadingBookAudiobookSlug;
          },
          builder: (context, state) {
            return AnimatedBoxFade(
              isChildVisible: state.downloadingBookAudiobookSlug != book.slug,
              child: CustomButton(
                icon: CustomIcons.delete_forever,
                onPressed: onDelete,
                backgroundColor: CustomColors.red,
                iconColor: CustomColors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TitleWithAuthors extends StatelessWidget {
  final BookModel book;
  const _TitleWithAuthors({required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          book.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        ...book.authors.map((author) {
          return Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  InkWellWrapper(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      router.pushNamed(
                        authorPageConfig.name,
                        pathParameters: {'slug': author.slug},
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        author.name,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        if (book.authors.isEmpty) const Spacer(),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({this.coverUrl});

  final String? coverUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.smallBorderRadius),
      child: (coverUrl ?? '').isEmpty
          ? Container(
              color: theme.colorScheme.surface,
              height: double.infinity,
              width: double.infinity,
            )
          : CachedNetworkImage(
              imageUrl: coverUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: SvgPicture.asset(Images.logo)),
            ),
    );
  }
}

class _HeartButton extends StatelessWidget {
  final BookModel book;
  const _HeartButton({required this.book});

  @override
  Widget build(BuildContext context) {
    final favouritesCubit = BlocProvider.of<LikesCubit>(context);
    return BlocBuilder<LikesCubit, LikesState>(
      buildWhen: (p, c) => p.favourites != c.favourites,
      builder: (context, state) {
        final isLiked = state.favourites.contains(book.slug);
        return AuthWrapper(
          authChild: (user) {
            return TextButtonWithIcon(
              nonActiveText: LocaleKeys.common_icon_button_like.tr(),
              nonActiveIcon: CustomIcons.favorite,
              activeColor: CustomColors.green,
              activeText: LocaleKeys.common_icon_button_liked.tr(),
              activeIcon: CustomIcons.favorite_filled,
              isActive: isLiked,
              onPressed: () {
                if (isLiked) {
                  favouritesCubit.removeFromFavourites(book.slug);
                  return;
                }

                favouritesCubit.addToFavourites(book.slug);
              },
            );
          },
          nonAuthChild: TextButtonWithIcon(
            nonActiveText: LocaleKeys.common_icon_button_like.tr(),
            nonActiveIcon: CustomIcons.favorite,
            isActive: false,
            onPressed: () {
              CustomSnackbar.success(
                context,
                LocaleKeys.common_snackbar_not_logged.tr(),
                icon: const Icon(Icons.login, size: 20),
                onIconTap: () {
                  router.pushNamed(
                    myLibraryPageConfig.name,
                    extra: MyLibraryEnum.login,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
