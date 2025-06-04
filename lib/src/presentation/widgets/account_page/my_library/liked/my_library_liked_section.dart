import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/liked/my_library_liked_book.dart';
import 'package:wolnelektury/src/presentation/widgets/common/load_more_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryLikedSection extends StatelessWidget {
  const MyLibraryLikedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        PageSubtitle(subtitle: MyLibraryEnum.liked.title),
        BlocBuilder<FavouritesCubit, FavouritesState>(
          buildWhen: (p, c) => p.itemsPerPage != c.itemsPerPage,
          builder: (context, state) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MyLibraryLikedBook(bookSlug: state.favourites[index]);
              },
              itemCount: state.effectiveLength,
            );
          },
        ),
        const SizedBox(height: Dimensions.spacer),
        BlocBuilder<FavouritesCubit, FavouritesState>(
          buildWhen: (p, c) => p.effectiveLength != c.effectiveLength,
          builder: (context, state) {
            if (state.effectiveLength == state.favourites.length) {
              return const SizedBox.shrink();
            }
            return LoadMoreButton(
              isLoading: false,
              onLoadMore: () {
                BlocProvider.of<FavouritesCubit>(
                  context,
                ).increaseItemsPerPage();
              },
            );
          },
        ),
      ],
    );
  }
}
