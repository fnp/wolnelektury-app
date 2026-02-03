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
import 'package:wolnelektury/src/features/common/widgets/auth_wrapper.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/common/widgets/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/lists/widgets/list_page_rename_dialog.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_delete_confirmation_dialog.dart';
import 'package:wolnelektury/src/utils/share/share_utils.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class MyLibraryListHeader extends StatelessWidget {
  final BookListModel bookList;
  final bool isListOwner;
  final bool isCompact;
  const MyLibraryListHeader({
    super.key,
    required this.bookList,
    required this.isListOwner,
    required this.isCompact,
  });

  void _onDeletePressed(
    BuildContext context, {
    required String slug,
    required String location,
  }) {
    final cubit = context.read<ListCreatorCubit>();
    MyLibraryListDeleteConfirmationDialog.show(
      context: context,
      onDelete: () {
        cubit.deleteList(
          slug,
          onSuccess: () {
            if (location.contains(listPageConfig.name)) {
              if (router.canPop()) {
                router.pop();
                cubit.getLists(force: true);
              }
            }
          },
        );
      },
    );
  }

  void _onAddPressed(BuildContext context) {
    final listCubit = context.read<ListCreatorCubit>();
    final modeCubit = context.read<AppModeCubit>();
    listCubit.setListAsEdited(bookList.slug);
    modeCubit.changeMode(AppModeEnum.listCreationMode);
    router.pushNamed(cataloguePageConfig.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routerPath = context.read<RouterCubit>().state.location;
    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: Dimensions.elementHeight,
          ),
          child: Column(
            spacing: Dimensions.largePadding,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: Dimensions.elementHeight,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusOfCircle,
                          ),
                          color: theme.colorScheme.surfaceContainer,
                        ),
                        child: InkWellWrapper(
                          borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusOfCircle,
                          ),
                          onTap: () {
                            if (routerPath.contains(listPageConfig.name)) {
                              if (!isListOwner) {
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
                                  child: Text(
                                    bookList.name,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: CustomColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: isCompact ? 1 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              if (!isCompact)
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.mediumPadding,
                                  ),
                                  child: Icon(Icons.edit_note_rounded),
                                ),
                              // Compact view as owner
                              if (isCompact && isListOwner)
                                SizedBox(
                                  width: Dimensions.elementHeight * 2,
                                  height: Dimensions.elementHeight,
                                  child: DecoratedBox(
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
                                          onDelete: () {
                                            _onDeletePressed(
                                              context,
                                              slug: bookList.slug,
                                              location: routerPath,
                                            );
                                          },
                                        ),
                                        _AddButton(
                                          bookList: bookList,
                                          onAdd: () {
                                            _onAddPressed(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Non compact view as owner
                  if (!isCompact && isListOwner) ...[
                    const SizedBox(width: Dimensions.mediumPadding),
                    _ShareButton(slug: bookList.slug),
                  ]
                  // Non compact view as not owner
                  else if (!isListOwner) ...[
                    const SizedBox(width: Dimensions.mediumPadding),
                    _SaveButton(bookList: bookList),
                  ],
                ],
              ),
              // Non compact view as owner
              if (!isCompact && isListOwner)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: Dimensions.mediumPadding,
                      children: [
                        Expanded(
                          child: TextButtonWithIcon(
                            nonActiveText: 'Usuń listę',
                            nonActiveIcon: CustomIcons.delete_forever,
                            isActive: false,
                            onPressed: () {
                              _onDeletePressed(
                                context,
                                slug: bookList.slug,
                                location: routerPath,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButtonWithIcon(
                            nonActiveText: 'Dodaj książki',
                            nonActiveIcon: CustomIcons.add,
                            isActive: false,
                            onPressed: () {
                              _onAddPressed(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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

class _AddButton extends StatelessWidget {
  final BookListModel bookList;
  final VoidCallback onAdd;
  const _AddButton({required this.bookList, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      semanticLabel: LocaleKeys.common_semantic_edit_list.tr(
        namedArgs: {'listName': bookList.name},
      ),
      icon: CustomIcons.add,
      onPressed: onAdd,
      backgroundColor: CustomColors.primaryYellowColor,
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final String slug;
  final String name;
  final VoidCallback onDelete;
  const _DeleteButton({
    required this.slug,
    required this.name,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: onDelete,
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

class _SaveButton extends StatelessWidget {
  final BookListModel bookList;
  const _SaveButton({required this.bookList});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListCreatorCubit, ListCreatorState>(
      listenWhen: (p, c) {
        return p.isSavingFailure != c.isSavingFailure ||
            p.isSavingEditedList != c.isSavingEditedList;
      },
      listener: (context, state) {
        if (!state.isSavingFailure && !state.isSavingEditedList) {
          CustomSnackbar.success(
            context,
            LocaleKeys.catalogue_list_creator_success.tr(),
          );
          return;
        }
        if (state.isSavingFailure) {
          CustomSnackbar.error(
            context,
            LocaleKeys.catalogue_list_creator_failure.tr(),
          );
        }
      },
      buildWhen: (p, c) {
        return p.isSavingEditedList != c.isSavingEditedList;
      },
      builder: (context, state) {
        return AuthWrapper(
          child: (isAuthenticated) {
            return Stack(
              children: [
                CustomButton(
                  semanticLabel: LocaleKeys.common_semantic_save_book_list.tr(),
                  icon: Icons.file_download_outlined,
                  onPressed: () {
                    if (!isAuthenticated) {
                      CustomSnackbar.loginRequired(context);
                      return;
                    }
                    final listCreatorCubit = context.read<ListCreatorCubit>();
                    listCreatorCubit.saveSharedList(bookList);
                  },
                  backgroundColor: CustomColors.white,
                ),
                if (state.isSavingEditedList)
                  const Positioned.fill(
                    child: CustomLoader(
                      strokeWidth: 2,
                      color: CustomColors.primaryYellowColor,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
