import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/features/common/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/lists/widgets/book_lists_create_widget.dart';
import 'package:wolnelektury/src/features/lists/widgets/book_lists_sheet_existing_lists.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookListsSheet extends StatelessWidget {
  final String bookSlug;
  const BookListsSheet({super.key, required this.bookSlug});

  static void show({
    required BuildContext context,
    required String bookSlug,
    required VoidCallback onSave,
  }) {
    showModalBottomSheet(
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Scaffold(
        body: GestureDetector(onTap: () => context.pop()),
        backgroundColor: Colors.transparent,
        bottomSheet: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ListCreatorCubit>()),
            BlocProvider.value(value: context.read<ScrollCubit>()),
          ],
          child: BlocListener<ListCreatorCubit, ListCreatorState>(
            listenWhen: (p, c) {
              return p.isDuplicateFailure != c.isDuplicateFailure;
            },
            listener: (context, state) {
              if (state.isDuplicateFailure) {
                CustomSnackbar.error(
                  context,
                  LocaleKeys.my_library_lists_rename_dialog_duplicate_error
                      .tr(),
                  messengerKey: CustomSnackbar.scaffoldMessengerKey,
                );
              }
            },
            child: BookListsSheet(bookSlug: bookSlug),
          ),
        ),
      ),
    ).then((_) {
      onSave.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableHeight = MediaQuery.sizeOf(context).height / 2;
    final cubit = BlocProvider.of<ListCreatorCubit>(context);
    return SafeArea(
      bottom: true,
      top: false,
      child: BlocBuilder<ListCreatorCubit, ListCreatorState>(
        buildWhen: (p, c) {
          return p.allLists != c.allLists;
        },
        builder: (context, state) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: availableHeight,
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.modalsPadding,
                vertical: Dimensions.mediumPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Dimensions.spacer),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.book_lists_sheet_title.tr().toUpperCase(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            height: 1.14,
                          ),
                        ),
                      ),
                      BlocBuilder<ListCreatorCubit, ListCreatorState>(
                        buildWhen: (p, c) {
                          return p.booksToAdd != c.booksToAdd ||
                              p.booksToRemove != c.booksToRemove;
                        },
                        builder: (context, state) {
                          final showCheck =
                              state.booksToAdd.isNotEmpty ||
                              state.booksToRemove.isNotEmpty;
                          return CustomButton(
                            semanticLabel: LocaleKeys
                                .common_semantic_close_book_lists
                                .tr(),
                            backgroundColor: showCheck
                                ? CustomColors.green
                                : CustomColors.white,
                            icon: showCheck ? Icons.check : Icons.close,
                            onPressed: () => Navigator.of(context).pop(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.mediumPadding),
                  Flexible(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: defaultCurve,
                      child: BookListsSheetExistingLists(
                        currentlyWorkingOnBookSlug: bookSlug,
                        effectiveList: state.allLists,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.mediumPadding),
                  BookListsCreateWidget(
                    onSave: (String text) {
                      cubit.newList(text, bookSlugs: [bookSlug]);
                    },
                  ),
                  const SizedBox(height: Dimensions.spacer),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
