import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class BookPage extends StatelessWidget {
  const BookPage({
    super.key,
    this.book,
  });

  final BookModel? book;

  @override
  Widget build(BuildContext context) {
    if (book == null) {
      return const Center(child: Text('Error'));
    }
    return _Content(
      book: book!,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audioCubit = BlocProvider.of<AudioCubit>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(
          Dimensions.mediumPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth / 2;
                final usableWidth =
                    availableWidth - (Dimensions.mediumPadding / 2);
                return SizedBox(
                  height: usableWidth / Dimensions.coverAspectRatio,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _Image(
                          coverUrl: book.coverUrl,
                        ),
                      ),
                      const SizedBox(width: Dimensions.mediumPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Dimensions.smallPadding),
                            ...book.authors.map(
                              (author) {
                                return author.name == null
                                    ? const SizedBox.shrink()
                                    : Expanded(
                                        child: Text(
                                          author.name!,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                              },
                            ),
                            TextButtonWithIcon(
                              nonActiveText:
                                  LocaleKeys.common_icon_button_read.tr(),
                              nonActiveIcon: CustomIcons.book_5,
                              onPressed: () {
                                router.pushNamed(
                                  readingPageConfig.name,
                                  pathParameters: {
                                    'slug': book.slug,
                                  },
                                  extra: book,
                                );
                              },
                            ),
                            const SizedBox(
                              height: Dimensions.mediumPadding,
                            ),
                            if (book.hasAudiobook) ...[
                              TextButtonWithIcon(
                                nonActiveText:
                                    LocaleKeys.common_icon_button_listen.tr(),
                                nonActiveIcon: CustomIcons.headphones,
                                onPressed: () {
                                  // Select proper book
                                  audioCubit.pickBook(
                                    book,
                                  );
                                  // Show audio dialog
                                  AudioDialog.show(
                                    context: context,
                                    onClosed: () => audioCubit.dialogShown(
                                      false,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: Dimensions.mediumPadding,
                              ),
                            ],
                            _HeartButton(book: book),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (book.description != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 40,
                  ),
                  child: SelectionArea(
                    child: Html(
                      data: book.description!,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
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
      borderRadius: BorderRadius.circular(
        Dimensions.smallBorderRadius,
      ),
      child: (coverUrl ?? '').isEmpty
          ? Container(
              color: theme.colorScheme.surface,
              height: double.infinity,
              width: double.infinity,
            )
          : CachedNetworkImage(
              imageUrl: coverUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: SvgPicture.asset(
                  Images.logo,
                ),
              ),
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
        final isLiked = state.favourites.keys.contains(
          book.slug,
        );
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
                  favouritesCubit.removeFromFavourites(
                    book.slug,
                  );
                  return;
                }

                favouritesCubit.addToFavourites(
                  book.slug,
                );
              },
            );
          },
          nonAuthChild: TextButtonWithIcon(
            nonActiveText: LocaleKeys.common_icon_button_like.tr(),
            nonActiveIcon: CustomIcons.favorite,
            isActive: false,
            onPressed: () {
              CustomSnackbar.error(
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
