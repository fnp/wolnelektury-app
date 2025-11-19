import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/presentation/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/app_mode_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/lists/my_library_list_book.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/lists/my_library_list_delete_confirmation_dialog.dart';
import 'package:wolnelektury/src/utils/share/share_utils.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class MyLibraryList extends StatelessWidget {
  final BookListModel bookList;
  final bool isCompact;
  const MyLibraryList({
    super.key,
    required this.bookList,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) {
        return p.doesLocalListExistsAlready(bookList.name) !=
            c.doesLocalListExistsAlready(bookList.name);
      },
      builder: (context, state) {
        final isExisting = state.doesLocalListExistsAlready(bookList.name);
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
                      _Header(bookList: bookList, includeShare: !isCompact),
                      if (bookList.books.isNotEmpty && !isCompact) ...[
                        _List(bookList: bookList),
                      ],
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
  const _List({required this.bookList});

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
        );
      },
      itemCount: bookList.books.length,
    );
  }
}

class _Header extends StatelessWidget {
  final BookListModel bookList;
  final bool includeShare;
  const _Header({required this.bookList, required this.includeShare});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listCubit = BlocProvider.of<ListCreatorCubit>(context);
    final modeCubit = BlocProvider.of<AppModeCubit>(context);
    return SizedBox(
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
                  router.pushNamed(
                    listPageConfig.name,
                    pathParameters: {'slug': bookList.slug},
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: CustomColors.red,
                          borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusOfCircle,
                          ),
                        ),
                        child: Row(
                          children: [
                            _DeleteButton(slug: bookList.slug),
                            CustomButton(
                              icon: CustomIcons.add,
                              onPressed: () {
                                print('Editing list: ${bookList.name}');
                                listCubit.setListAsEdited(bookList.name);
                                modeCubit.changeMode(
                                  AppModeEnum.listCreationMode,
                                );
                                router.pushNamed(cataloguePageConfig.name);
                              },
                              backgroundColor: CustomColors.white,
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
          if (includeShare) ...[
            const SizedBox(width: Dimensions.mediumPadding),
            _ShareButton(slug: bookList.slug),
          ],
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final String slug;
  const _DeleteButton({required this.slug});

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
                      CustomLoader(size: 16, color: CustomColors.white),
                    ],
                  ),
                )
              : CustomButton(
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
      icon: CustomIcons.ios_share,
      onPressed: () {
        ShareUtils.shareBookList(slug);
      },
      backgroundColor: CustomColors.white,
    );
  }
}
