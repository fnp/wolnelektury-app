import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/likes/likes_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/empty_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/liked/my_library_liked_book.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

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
            child: BlocBuilder<LikesCubit, LikesState>(
              buildWhen: (p, c) {
                return p.itemsPerPage != c.itemsPerPage ||
                    p.favourites.isNotEmpty && c.favourites.isEmpty ||
                    p.isLoading != c.isLoading;
              },
              builder: (context, state) {
                if (state.favourites.isEmpty && !state.isLoading) {
                  //todo translations
                  return EmptyWidget(
                    image: Images.empty,
                    message: 'Nie polubiono jeszcze żadnych książek',
                    buttonText: 'Przeglądaj katalog',
                    onTap: () {
                      router.goNamed(cataloguePageConfig.name);
                    },
                  );
                }
                return CustomScrollPage(
                  onRefresh: () {
                    return context.read<LikesCubit>().init();
                  },
                  onLoadMore: () {
                    context.read<LikesCubit>().increaseItemsPerPage();
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
