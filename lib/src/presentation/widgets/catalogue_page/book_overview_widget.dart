import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_lists/book_lists_sheet.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_overview_widget_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_button.dart';
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

    return BlocBuilder<AppModeCubit, AppModeState>(
      buildWhen: (p, c) => p.mode != c.mode,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state.isListCreation) {
              final creationCubit = BlocProvider.of<ListCreatorCubit>(context);
              if (creationCubit.state.isBookInEditedList(book.slug)) {
                creationCubit.removeBookFromEditedList(book.slug);
                return;
              }
              creationCubit.addBookToEditedList(book.slug);
              return;
            }

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
                    borderRadius: getBorderRadius(state.isListCreation),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if ((book.coverUrl ?? '').isEmpty) {
                          // Skeleton
                          return Container(
                            color: theme.colorScheme.surface,
                            height: constraints.maxWidth /
                                Dimensions.coverAspectRatio,
                            width: constraints.maxWidth,
                          );
                        }
                        return _ImageWithFilter(
                          book: book,
                          constraints: constraints,
                        );
                      },
                    ),
                  ),
                  if (state.isListCreation)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: _AddToListButton(book.slug),
                    ),
                  if (state.isDefault)
                    Positioned(
                      right: 10,
                      bottom: 40,
                      child: _HeartButton(
                        book: book,
                      ),
                    ),
                  if (state.isDefault)
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: BookOverviewWidgetButton(
                        onTap: () {
                          final cubit =
                              BlocProvider.of<ListCreatorCubit>(context);

                          cubit.init(force: true);
                          BookListsSheet.show(
                            context: context,
                            bookSlug: book.slug,
                            onSave: () {
                              cubit.save();
                            },
                          );
                        },
                        nonActiveBackgroundColor: CustomColors.white,
                        activeBackgroundColor: CustomColors.primaryYellowColor,
                        nonActiveIcon: CustomIcons.playlist_add,
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
      },
    );
  }

  BorderRadius getBorderRadius(bool isListCreation) {
    return isListCreation
        ? const BorderRadius.only(
            bottomLeft: Radius.circular(
              Dimensions.smallBorderRadius,
            ),
            bottomRight: Radius.circular(
              Dimensions.elementHeight / 2,
            ),
            topLeft: Radius.circular(
              Dimensions.smallBorderRadius,
            ),
            topRight: Radius.circular(
              Dimensions.smallBorderRadius,
            ),
          )
        : BorderRadius.circular(
            Dimensions.smallBorderRadius,
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

class _AddToListButton extends StatelessWidget {
  final String slug;
  const _AddToListButton(this.slug);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ListCreatorCubit>(context);
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) =>
          p.isBookInEditedList(slug) != c.isBookInEditedList(slug),
      builder: (context, state) {
        final isBookInEditedList = state.isBookInEditedList(slug);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchOutCurve: Curves.fastOutSlowIn,
          switchInCurve: Curves.fastOutSlowIn,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: CustomButton(
            key: ValueKey(isBookInEditedList),
            icon: isBookInEditedList ? Icons.check : CustomIcons.add,
            backgroundColor:
                isBookInEditedList ? CustomColors.green : CustomColors.white,
            iconColor: CustomColors.black,
            onPressed: () {
              if (isBookInEditedList) {
                cubit.removeBookFromEditedList(slug);
                return;
              }

              cubit.addBookToEditedList(slug);
            },
          ),
        );
      },
    );
  }
}

class _ImageWithFilter extends StatelessWidget {
  final BookModel book;
  final BoxConstraints constraints;
  const _ImageWithFilter({
    required this.book,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final colorFilterMatrix = <double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ];

    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) =>
          p.isBookInEditedList(book.slug) != c.isBookInEditedList(book.slug),
      builder: (context, state) {
        final shouldFilter = state.isBookInEditedList(book.slug);

        final child = CachedNetworkImage(
          imageUrl: book.coverUrl!,
          fit: BoxFit.cover,
          placeholder: (context, url) => SizedBox(
            height: constraints.maxWidth / Dimensions.coverAspectRatio,
            child: Center(
              child: SvgPicture.asset(
                Images.logo,
                width: constraints.maxWidth - Dimensions.largePadding,
              ),
            ),
          ),
        );

        if (shouldFilter) {
          // Apply color filter only if the book is in the edited list
          return ColorFiltered(
            colorFilter: ColorFilter.matrix(colorFilterMatrix),
            child: child,
          );
        }

        return child;
      },
    );
  }
}
