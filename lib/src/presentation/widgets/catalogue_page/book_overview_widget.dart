import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_lists/book_lists_sheet.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_overview_widget_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class BookOverviewWidget extends StatelessWidget {
  const BookOverviewWidget({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        router.pushNamed(
          bookPageConfig.name,
          pathParameters: {
            'slug': book.slug,
          },
          extra: book,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  Dimensions.smallBorderRadius,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if ((book.coverUrl ?? '').isEmpty) {
                      // Skeleton
                      return Container(
                        color: theme.colorScheme.surface,
                        height:
                            constraints.maxWidth / Dimensions.coverAspectRatio,
                        width: constraints.maxWidth,
                      );
                    }
                    return CachedNetworkImage(
                      imageUrl: book.coverUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                        height:
                            constraints.maxWidth / Dimensions.coverAspectRatio,
                        child: Center(
                          child: SvgPicture.asset(
                            Images.logo,
                            width:
                                constraints.maxWidth - Dimensions.largePadding,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                right: 10,
                bottom: 40,
                child: _HeartButton(
                  book: book,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: BookOverviewWidgetButton(
                  onTap: () {
                    BookListsSheet.show(
                      context: context,
                    );
                  },
                  nonActiveBackgroundColor: CustomColors.white,
                  activeBackgroundColor: CustomColors.primaryYellowColor,
                  nonActiveIcon: Icons.playlist_add,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.smallPadding,
          ),
          Flexible(
            child: Text(
              book.title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: Dimensions.smallPadding),
          Expanded(
            child: Text(
              book.authors.map((author) => author.name).join(', '),
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
            return BookOverviewWidgetButton(
              nonActiveBackgroundColor: CustomColors.white,
              activeBackgroundColor: CustomColors.primaryYellowColor,
              nonActiveIcon: CustomIcons.favorite_filled,
              activeIcon: CustomIcons.favorite_filled,
              onTap: () {
                if (isLiked) {
                  favouritesCubit.removeFromFavourites(book.slug);
                  return;
                }

                favouritesCubit.addToFavourites(book.slug);
              },
              isActive: isLiked,
            );
          },
          nonAuthChild: BookOverviewWidgetButton(
            nonActiveBackgroundColor: CustomColors.white,
            nonActiveIcon: CustomIcons.favorite_filled,
            onTap: () {
              CustomSnackbar.error(
                context,
                LocaleKeys.common_snackbar_not_logged.tr(),
              );
            },
            isActive: false,
          ),
        );
      },
    );
  }
}
