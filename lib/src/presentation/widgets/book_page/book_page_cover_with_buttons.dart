import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class BookPageCoverWithButtons extends StatelessWidget {
  final BookModel book;
  final VoidCallback? onDelete;
  const BookPageCoverWithButtons({
    super.key,
    required this.book,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth / 2;
        final usableWidth = availableWidth - (Dimensions.mediumPadding / 2);
        return SizedBox(
          height: usableWidth / Dimensions.coverAspectRatio,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _Image(coverUrl: book.coverUrl)),
              const SizedBox(width: Dimensions.mediumPadding),
              Expanded(
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
                    TextButtonWithIcon(
                      nonActiveText: LocaleKeys.common_icon_button_read.tr(),
                      nonActiveIcon: CustomIcons.book_5,
                      onPressed: () {
                        router.pushNamed(
                          readingPageConfig.name,
                          pathParameters: {'slug': book.slug},
                          extra: book,
                        );
                      },
                    ),
                    const SizedBox(height: Dimensions.mediumPadding),
                    if (book.hasAudiobook) ...[
                      TextButtonWithIcon(
                        nonActiveText: LocaleKeys.common_icon_button_listen
                            .tr(),
                        nonActiveIcon: CustomIcons.headphones,
                        onPressed: () {
                          // Select proper book
                          audioCubit.pickBook(book);
                          // Show audio dialog
                          AudioDialog.show(
                            context: context,
                            onClosed: () => audioCubit.dialogShown(false),
                            slug: book.slug,
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.mediumPadding),
                    ],
                    _HeartButton(book: book),
                    TextButtonWithIcon(
                      nonActiveText: 'Pobierz audiobook',
                      nonActiveIcon: Icons.download,
                      onPressed: () {
                        BlocProvider.of<DownloadCubit>(
                          context,
                        ).downloadAudiobook(book: book);
                      },
                    ),
                  ],
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
        CustomButton(
          icon: CustomIcons.delete_forever,
          onPressed: onDelete,
          backgroundColor: CustomColors.red,
          iconColor: CustomColors.white,
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
          );
        }),
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
    final favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
    return BlocBuilder<FavouritesCubit, FavouritesState>(
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
              );
            },
          ),
        );
      },
    );
  }
}
