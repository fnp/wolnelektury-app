import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

/// Whole list is rebuilt ONLY when isLoading changes.
/// Every book in lists rebuilds separately based on whether it's in the list or not,
/// so adding/removing book from list doesn't cause whole list to rebuild,
/// only the specific book that is added/removed.
/// This is achieved by using BlocBuilder with buildWhen that checks
/// if the list slug matches and if the book is in the list, so only the specific
/// book widget rebuilds when it's added/removed from the list.
class ListPage extends StatelessWidget {
  final String? slug;
  final bool isListOwner;
  const ListPage({super.key, required this.slug, this.isListOwner = true});

  @override
  Widget build(BuildContext context) {
    if (slug != null) {
      return Content(
        slug: slug!,
        isListOwner: isListOwner,
        key: ValueKey(slug!),
      );
    } else {
      return const _EmptyWidget();
    }
  }
}

class Content extends StatefulWidget {
  final String slug;
  final bool isListOwner;
  const Content({super.key, required this.slug, required this.isListOwner});

  @override
  State<Content> createState() => ContentState();
}

class ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ListCreatorCubit>()..getListBySlug(widget.slug),
      child: BlocBuilder<ListCreatorCubit, ListCreatorState>(
        buildWhen: (p, c) {
          return p.isLoading != c.isLoading ||
              p.fetchedSingleList != c.fetchedSingleList;
        },
        builder: (context, state) {
          final list = state.fetchedSingleList;
          if (list == null && !state.isLoading) {
            return const _EmptyWidget();
          }

          return Align(
            alignment: Alignment.topCenter,
            child: _Body(
              bookList: list ?? BookListModel.empty(),
              key: ValueKey(list?.slug ?? 'empty'),
              isListOwner: widget.isListOwner,
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final BookListModel bookList;
  final bool isListOwner;
  const _Body({required this.bookList, required this.isListOwner, super.key});

  @override
  Widget build(BuildContext context) {
    if (bookList.books.isEmpty) {
      return const _EmptyWidget();
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.mediumPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: Dimensions.spacer / 2),
            MyLibraryList(
              bookList: bookList,
              isCompact: false,
              isListOwner: isListOwner,
            ),
            const SizedBox(height: Dimensions.spacer),
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
