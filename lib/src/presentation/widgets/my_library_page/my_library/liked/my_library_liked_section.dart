import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/liked/my_library_liked_book.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryLikedSection extends StatelessWidget {
  const MyLibraryLikedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageSubtitle(subtitle: MyLibraryEnum.liked.title),
          Expanded(
            child: BlocBuilder<FavouritesCubit, FavouritesState>(
              buildWhen: (p, c) => p.itemsPerPage != c.itemsPerPage,
              builder: (context, state) {
                return CustomScrollPage(
                  onLoadMore: () {
                    context.read<FavouritesCubit>().increaseItemsPerPage();
                  },
                  builder: (scrollController) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return MyLibraryLikedBook(
                          key: ValueKey(state.favourites[index]),
                          bookSlug: state.favourites[index],
                        );
                      },
                      itemCount: state.effectiveLength,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
