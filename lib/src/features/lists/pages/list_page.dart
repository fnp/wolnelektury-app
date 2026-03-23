import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
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
              p.fetchedSingleList?.name != c.fetchedSingleList?.name;
        },
        builder: (context, state) {
          final list = state.fetchedSingleList;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: defaultCurve,
            switchOutCurve: defaultCurve,
            child: list == null
                ? const _EmptyWidget()
                : Align(
                    alignment: Alignment.topCenter,
                    child: _Body(
                      itemList: list,
                      key: ValueKey(list.slug),
                      isListOwner: widget.isListOwner,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ListModel itemList;
  final bool isListOwner;
  const _Body({required this.itemList, required this.isListOwner, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: defaultCurve,
      switchOutCurve: defaultCurve,
      child: itemList.items.isEmpty
          ? const _EmptyWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
              ),
              child: MyLibraryList(
                itemList: itemList,
                isCompact: false,
                isListOwner: isListOwner,
              ),
            ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) {
        return p.isLoading != c.isLoading;
      },
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: defaultCurve,
          switchOutCurve: defaultCurve,
          child: state.isLoading
              ? const CustomLoader()
              : EmptyWidget(
                  image: Images.empty,
                  message: LocaleKeys.common_empty_lists_content_title.tr(),
                  onTap: () {
                    router.pushNamed(cataloguePageConfig.name);
                  },
                  buttonText: LocaleKeys.common_empty_search_in_catalogue.tr(),
                ),
        );
      },
    );
  }
}
