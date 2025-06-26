import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryLikedBook extends StatelessWidget {
  final String bookSlug;
  const MyLibraryLikedBook({super.key, required this.bookSlug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SingleBookCubit(get.get(), get.get())
          ..loadBookData(slug: bookSlug);
      },
      child: BlocBuilder<SingleBookCubit, SingleBookState>(
        buildWhen: (p, c) {
          return p.book != c.book || p.isLoading != c.isLoading;
        },
        builder: (context, state) {
          if (!state.isLoading && state.book == null) {
            return const SizedBox.shrink();
          }
          return BlocBuilder<FavouritesCubit, FavouritesState>(
            buildWhen: (p, c) {
              return p.isLiked(bookSlug) != c.isLiked(bookSlug);
            },
            builder: (context, innerState) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: innerState.isLiked(bookSlug)
                    ? Skeletonizer(
                        enableSwitchAnimation: true,
                        enabled: state.isLoading,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: Dimensions.spacer,
                          ),
                          child: BookPageCoverWithButtons(
                            book: state.isLoading
                                ? BookModel.empty()
                                : state.book!,
                          ),
                        ),
                      )
                    : const SizedBox(width: double.infinity),
              );
            },
          );
        },
      ),
    );
  }
}
