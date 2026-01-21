import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/enums/app_mode_enum.dart';
import 'package:wolnelektury/src/features/common/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/lists/widgets/list_page_rename_dialog.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_book.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_delete_confirmation_dialog.dart';
import 'package:wolnelektury/src/utils/share/share_utils.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class MyLibraryList extends StatelessWidget {
  final BookListModel bookList;
  final bool isCompact;
  final bool canEdit;
  const MyLibraryList({
    super.key,
    required this.bookList,
    required this.isCompact,
    this.canEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) {
        return p.doesLocalListExistsAlready(bookList.slug) !=
            c.doesLocalListExistsAlready(bookList.slug);
      },
      builder: (context, state) {
        final isExisting =
            state.doesLocalListExistsAlready(bookList.slug) ||
            state.fetchedSingleList?.slug == bookList.slug;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          alignment: Alignment.topCenter,
          child: isExisting
              ? Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.spacer),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Header(
                        bookList: bookList,
                        includeShare: !isCompact,
                        canEdit: canEdit,
                      ),
                      if (bookList.books.isNotEmpty && !isCompact) ...[
                        _List(bookList: bookList, canEdit: canEdit),
                      ],
                      if (bookList.books.isEmpty && !isCompact)
                        const Padding(
                          padding: EdgeInsets.only(top: Dimensions.spacer),
                          child: _EmptyWidget(),
                        ),
                    ],
                  ),
                )
              : const SizedBox(width: double.infinity),
        );
      },
    );
  }
}

class _List extends StatelessWidget {
  final BookListModel bookList;
  final bool canEdit;
  const _List({required this.bookList, required this.canEdit});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return MyLibraryListBook(
          key: ValueKey(bookList.books[index]),
          bookSlug: bookList.books[index],
          listSlug: bookList.slug,
          listName: bookList.name,
          canEdit: canEdit,
        );
      },
      itemCount: bookList.books.length,
    );
  }
}

class _Header extends StatelessWidget {
  final BookListModel bookList;
  final bool includeShare;
  final bool canEdit;
  const _Header({
    required this.bookList,
    required this.includeShare,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listCubit = BlocProvider.of<ListCreatorCubit>(context);
    final modeCubit = BlocProvider.of<AppModeCubit>(context);
    final routerPath = context.read<RouterCubit>().state.location;
    return Stack(
      children: [
        SizedBox(
          height: Dimensions.elementHeight,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    color: CustomColors.primaryYellowColor,
                  ),
                  child: InkWellWrapper(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    onTap: () {
                      if (routerPath.contains(listPageConfig.name)) {
                        if (!canEdit) {
                          return;
                        }
                        ListPageRenameDialog.show(
                          context: context,
                          listSlug: bookList.slug,
                          currentName: bookList.name,
                        );
                        return;
                      }
                      router.pushNamed(
                        listPageConfig.name,
                        pathParameters: {'slug': bookList.slug},
                        extra: true,
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.veryLargePadding,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                bookList.name,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: CustomColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.elementHeight * 2,
                          height: Dimensions.elementHeight,
                          child: canEdit
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: CustomColors.red,
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusOfCircle,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _DeleteButton(
                                        slug: bookList.slug,
                                        name: bookList.name,
                                      ),
                                      CustomButton(
                                        semanticLabel: LocaleKeys
                                            .common_semantic_edit_list
                                            .tr(
                                              namedArgs: {
                                                'listName': bookList.name,
                                              },
                                            ),
                                        icon: CustomIcons.add,
                                        onPressed: () {
                                          listCubit.setListAsEdited(
                                            bookList.slug,
                                          );
                                          modeCubit.changeMode(
                                            AppModeEnum.listCreationMode,
                                          );
                                          router.pushNamed(
                                            cataloguePageConfig.name,
                                          );
                                        },
                                        backgroundColor: CustomColors.white,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (includeShare) ...[
                const SizedBox(width: Dimensions.mediumPadding),
                _ShareButton(slug: bookList.slug),
              ],
            ],
          ),
        ),
        Positioned.fill(
          child: BlocBuilder<ListCreatorCubit, ListCreatorState>(
            buildWhen: (p, c) {
              return (p.pendingList?.name != c.pendingList?.name) &&
                  (c.pendingList?.name == bookList.name);
            },
            builder: (context, state) {
              if (state.pendingList?.name != bookList.name) {
                return const SizedBox.shrink();
              }
              return ColoredBox(
                color: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
                child: const Center(
                  child: CustomLoader(
                    size: 15,
                    strokeWidth: 2,
                    color: CustomColors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final String slug;
  final String name;
  const _DeleteButton({required this.slug, required this.name});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ListCreatorCubit>(context);
    final location = context.read<RouterCubit>().state.location;
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) => p.deletingSlug != c.deletingSlug,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: defaultCurve,
          switchOutCurve: defaultCurve,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: state.deletingSlug == slug
              ? const SizedBox(
                  width: Dimensions.elementHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomLoader(size: 15, color: CustomColors.white),
                    ],
                  ),
                )
              : CustomButton(
                  semanticLabel: LocaleKeys.common_semantic_delete_list.tr(
                    namedArgs: {'listName': name},
                  ),
                  icon: CustomIcons.delete_forever,
                  onPressed: () {
                    MyLibraryListDeleteConfirmationDialog.show(
                      context: context,
                      onDelete: () {
                        cubit.deleteList(
                          slug,
                          onSuccess: () {
                            if (location.contains(listPageConfig.name)) {
                              if (router.canPop()) {
                                router.pop();
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                  backgroundColor: CustomColors.red,
                  iconColor: CustomColors.white,
                ),
        );
      },
    );
  }
}

class _ShareButton extends StatelessWidget {
  final String slug;
  const _ShareButton({required this.slug});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      semanticLabel: LocaleKeys.common_semantic_share_book_list.tr(),
      icon: CustomIcons.ios_share,
      onPressed: () {
        ShareUtils.shareBookList(slug);
      },
      backgroundColor: CustomColors.white,
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
