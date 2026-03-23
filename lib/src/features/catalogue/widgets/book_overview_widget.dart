import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/features/catalogue/widgets/buttons/book_overview_widget_create_list_button.dart';
import 'package:wolnelektury/src/features/catalogue/widgets/buttons/book_overview_widget_heart_button.dart';
import 'package:wolnelektury/src/features/catalogue/widgets/buttons/book_overview_widget_list_creation_mode_button.dart';
import 'package:wolnelektury/src/features/common/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class BookOverviewWidget extends StatelessWidget {
  const BookOverviewWidget({
    super.key,
    required this.book,
    required this.gridNumber,
  });

  final BookModel book;
  final int gridNumber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveScale = 3 - gridNumber * 2 / 3;

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
              pathParameters: {'slug': book.slug},
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
                            height:
                                constraints.maxWidth /
                                Dimensions.coverAspectRatio,
                            width: constraints.maxWidth,
                          );
                        }
                        return _ImageWithFilter(
                          book: book,
                          constraints: constraints,
                          shouldFilter: state.isListCreation,
                        );
                      },
                    ),
                  ),
                  if (state.isListCreation)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Transform.scale(
                        scale: effectiveScale,
                        child: BookOverviewWidgetListCreationModeButton(
                          book.slug,
                        ),
                      ),
                    ),
                  if (state.isDefault && book.hasAudiobook)
                    Positioned(
                      left: 10 * effectiveScale,
                      bottom: 10 * effectiveScale,
                      child: Transform.scale(
                        scale: effectiveScale,
                        child: const _AudiobookMarker(),
                      ),
                    ),
                  if (state.isDefault)
                    Positioned(
                      right: 10 * effectiveScale,
                      bottom: 40 * effectiveScale,
                      child: Transform.scale(
                        scale: effectiveScale,
                        child: BookOverviewWidgetHeartButton(book: book),
                      ),
                    ),
                  if (state.isDefault)
                    Positioned(
                      right: 10 * effectiveScale,
                      bottom: 10 * effectiveScale,
                      child: Transform.scale(
                        scale: effectiveScale,
                        child: BookOverviewWidgetCreateListButton(book: book),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: Dimensions.smallPadding),
              Text(
                book.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Dimensions.smallPadding),
              Text(
                book.authors.map((author) => author.name).join(', '),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Dimensions.smallPadding),
            ],
          ),
        );
      },
    );
  }

  BorderRadius getBorderRadius(bool isListCreation) {
    return isListCreation
        ? const BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.smallBorderRadius),
            bottomRight: Radius.circular(Dimensions.elementHeight / 2),
            topLeft: Radius.circular(Dimensions.smallBorderRadius),
            topRight: Radius.circular(Dimensions.smallBorderRadius),
          )
        : BorderRadius.circular(Dimensions.smallBorderRadius);
  }
}

class _AudiobookMarker extends StatelessWidget {
  const _AudiobookMarker();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 25,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.white,
        ),
        child: const Icon(
          CustomIcons.headphones,
          color: CustomColors.black,
          size: 13,
        ),
      ),
    );
  }
}

class _ImageWithFilter extends StatelessWidget {
  final BookModel book;
  final BoxConstraints constraints;
  final bool shouldFilter;
  const _ImageWithFilter({
    required this.book,
    required this.constraints,
    required this.shouldFilter,
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
      buildWhen: (p, c) {
        return p.isBookInEditedList(book.slug) !=
            c.isBookInEditedList(book.slug);
      },
      builder: (context, state) {
        final effShouldFilter =
            state.isBookInEditedList(book.slug) && shouldFilter;

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

        if (effShouldFilter) {
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
