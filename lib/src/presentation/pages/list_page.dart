import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/empty_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/lists/my_library_list.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class ListPage extends StatelessWidget {
  final String? slug;
  const ListPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    if (slug != null) {
      return _FetchedListWidget(slug: slug!);
    } else {
      return const _EmptyWidget();
    }
  }
}

class _FetchedListWidget extends StatelessWidget {
  final String slug;
  const _FetchedListWidget({required this.slug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ListCreatorCubit(get.get())..getListBySlug(slug);
      },
      child: BlocBuilder<ListCreatorCubit, ListCreatorState>(
        buildWhen: (p, c) {
          return p.allLists != c.allLists || p.isLoading != c.isLoading;
        },
        builder: (context, state) {
          final list = state.allLists.firstOrNull;
          if (list == null && !state.isLoading) {
            return const _EmptyWidget();
          }

          return AnimatedBoxFade(
            isChildVisible: !state.isLoading,
            collapsedChild: const Center(child: CircularProgressIndicator()),
            child: _Body(bookList: list ?? BookListModel.empty()),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final BookListModel bookList;
  const _Body({required this.bookList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.mediumPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: Dimensions.largePadding),
            MyLibraryList(bookList: bookList, isCompact: false),
            const SizedBox(height: Dimensions.largePadding),
          ],
        ),
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      image: Images.empty,
      message: LocaleKeys.common_empty_lists_content_title.tr(),
      onTap: () {
        router.pushNamed(cataloguePageConfig.name);
      },
      buttonText: LocaleKeys.common_empty_search_in_catalogue.tr(),
    );
  }
}
