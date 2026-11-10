import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/features/common/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/common/widgets/quotes/quote_widget.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_editor/list_editor_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/quotes/my_library_quote_dialog.dart';
import 'package:wolnelektury/src/features/readers/cubits/quotes/quotes_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

/// Single quote of the "My quotes" section, deletable with an undo option.
class MyLibraryQuoteElement extends StatelessWidget {
  final QuoteModel quote;

  const MyLibraryQuoteElement({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    final isInListMode = context
        .read<AppModeCubit>()
        .state
        .isListQuotesCreation;

    void onSelectTap() {
      // Quotes that weren't synced yet don't exist on the server.
      if (!quote.isSynced) return;
      final editorCubit = context.read<ListEditorCubit>();
      if (editorCubit.state.isItemInEditedList(quote.uuid!)) {
        editorCubit.removeElement(quoteUuid: quote.uuid!);
        return;
      }
      editorCubit.addElement(quoteUuid: quote.uuid!);
    }

    return BlocBuilder<QuotesCubit, QuotesState>(
      buildWhen: (p, c) {
        return p.quoteToDelete?.uuid != c.quoteToDelete?.uuid ||
            p.quoteExists(quote.uuid) != c.quoteExists(quote.uuid);
      },
      builder: (context, state) {
        final shouldHide =
            state.quoteToDelete?.uuid == quote.uuid ||
            !state.quoteExists(quote.uuid);

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          child: shouldHide
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(
                    bottom: Dimensions.largePadding,
                  ),
                  child: BlocBuilder<ListEditorCubit, ListEditorState>(
                    buildWhen: (p, c) {
                      return p.isItemInEditedList(quote.uuid ?? '') !=
                          c.isItemInEditedList(quote.uuid ?? '');
                    },
                    builder: (context, editorState) {
                      final selectedToAdd =
                          isInListMode &&
                          editorState.isItemInEditedList(quote.uuid ?? '');
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: defaultCurve,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.smallBorderRadius,
                          ),
                          color: selectedToAdd
                              ? CustomColors.grey
                              : Colors.transparent,
                        ),
                        child: InkWellWrapper(
                          borderRadius: BorderRadius.circular(
                            Dimensions.smallBorderRadius,
                          ),
                          onTap: isInListMode
                              ? onSelectTap
                              : () {
                                  MyLibraryQuoteDialog.show(
                                    context: context,
                                    quote: quote,
                                  );
                                },
                          child: Padding(
                            padding: const EdgeInsets.all(
                              Dimensions.smallPadding,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Opacity(
                                    opacity:
                                        selectedToAdd ||
                                            (isInListMode && !quote.isSynced)
                                        ? 0.4
                                        : 1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: Dimensions.mediumPadding,
                                        ),
                                        const Icon(
                                          Icons.format_quote,
                                          color:
                                              CustomColors.secondaryBlueColor,
                                          size: 32,
                                        ),
                                        const SizedBox(
                                          width: Dimensions.largePadding,
                                        ),
                                        Expanded(
                                          child: QuoteWidget(quote: quote),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isInListMode)
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 550),
                                    reverseDuration: const Duration(
                                      milliseconds: 150,
                                    ),
                                    switchOutCurve: Curves.easeIn,
                                    switchInCurve: Curves.elasticOut,
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    child: CustomButton(
                                      key: ValueKey(selectedToAdd),
                                      semanticLabel: selectedToAdd
                                          ? LocaleKeys
                                                .common_semantic_remove_from_edited_list
                                                .tr()
                                          : LocaleKeys
                                                .common_semantic_add_to_edited_list
                                                .tr(),
                                      icon: selectedToAdd
                                          ? Icons.check
                                          : CustomIcons.add,
                                      backgroundColor: selectedToAdd
                                          ? CustomColors.green
                                          : CustomColors.white,
                                      iconColor: CustomColors.black,
                                      size: 36,
                                      iconSize: 20,
                                      onPressed: quote.isSynced
                                          ? onSelectTap
                                          : null,
                                    ),
                                  )
                                else ...[
                                  const SizedBox(
                                    width: Dimensions.smallPadding,
                                  ),
                                  CustomButton(
                                    semanticLabel: LocaleKeys
                                        .common_semantic_delete_quote
                                        .tr(),
                                    onPressed: () {
                                      cubit.deleteQuote(quote: quote);
                                      CustomSnackbar.success(
                                        context,
                                        LocaleKeys
                                            .reader_snackbar_quote_deleted_success
                                            .tr(),
                                        onRevert: cubit.undoDeletion,
                                      );
                                    },
                                    icon: CustomIcons.delete_forever,
                                    backgroundColor: CustomColors.red,
                                    iconColor: CustomColors.white,
                                    size: 36,
                                    iconSize: 20,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
