import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';
import 'package:wolnelektury/src/presentation/enums/success_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/paragraph_sheet/reading_page_paragraph_sheet.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/build_reader_spans_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class ReadingPage extends StatelessWidget {
  final BookModel? book;
  const ReadingPage({super.key, required this.book});

  void onLongPress({
    required ReadingPageCubit cubit,
    required BuildContext context,
    int? index,
    ReaderBookModelContent? element,
  }) {
    HapticFeedback.selectionClick();
    cubit.selectParagraph(
      index: index,
      element: element,
    );
    ReadingPageParagraphSheet.show(
      context: context,
      onClosed: () {
        cubit.selectParagraph();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (book == null) {
      return const Center(child: Text('Error'));
    }
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          ReadingPageCubit(get.get(), get.get())..init(book: book!),
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<ReadingPageCubit>(context);
          return BlocListener<ReadingPageCubit, ReadingPageState>(
            listenWhen: (p, c) => p.isBookmarkSuccess != c.isBookmarkSuccess,
            listener: (context, state) {
              if (state.isBookmarkSuccess == null) return;
              determineSnackbar(
                context: context,
                state: state.isBookmarkSuccess!,
              );
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: BlocBuilder<ReadingPageCubit, ReadingPageState>(
                    buildWhen: (p, c) => c.shouldRebuild(p),
                    builder: (context, state) {
                      return AnimatedBoxFade(
                        duration: const Duration(milliseconds: 400),
                        isChildVisible: !state.isJsonLoading,
                        collapsedChild: const Center(
                          child: CustomLoader(
                            color: CustomColors.secondaryBlueColor,
                          ),
                        ),
                        child: state.book == null
                            ? const SizedBox.shrink()
                            : MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  textScaler: const TextScaler.linear(1),
                                ),
                                child: ListView.builder(
                                  itemCount: state.book!.contents.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return _Header(
                                        state: state,
                                      );
                                    }
                                    final element =
                                        state.book!.contents[index - 1];
                                    return InkWellWrapper(
                                      onTap: () => cubit.selectParagraph(),
                                      onLongPress: () => onLongPress(
                                        cubit: cubit,
                                        index: index,
                                        element: element,
                                        context: context,
                                      ),
                                      child: Stack(
                                        children: [
                                          _YellowBackground(index),
                                          BuildReaderSpansWrapper(
                                            element: element,
                                            fontFamily:
                                                state.fontType.familyName,
                                            fontSize: state.getFontSize(theme),
                                            debugPrint: true,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: Dimensions.modalsPadding,
                  right: Dimensions.modalsPadding,
                  child: CustomButton(
                    size: Dimensions.elementHeight,
                    backgroundColor: CustomColors.white,
                    icon: Icons.tune,
                    onPressed: () {
                      ReadingPageSettings.show(
                        context: context,
                        onClosed: () {
                          cubit.saveSettings();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void determineSnackbar({
    required BuildContext context,
    required SuccessState state,
  }) {
    switch (state.$1) {
      case Success.update:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_edited_success.tr(),
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_edit_error.tr(),
          );
        }
        break;
      case Success.delete:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_deleted_success.tr(),
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_delete_error.tr(),
          );
        }
        break;
      case Success.create:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_added_success.tr(),
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_add_error.tr(),
          );
        }
        break;
    }
  }
}

class _YellowBackground extends StatelessWidget {
  const _YellowBackground(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingPageCubit, ReadingPageState>(
      buildWhen: (p, c) => p.selectedIndex != c.selectedIndex,
      builder: (context, innerState) {
        return Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 34,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: innerState.selectedIndex == index
                    ? CustomColors.primaryYellowColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final ReadingPageState state;
  const _Header({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.veryLargePadding,
        children: [
          if (state.book!.headerLeft != null)
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: buildReaderBase(
                    theme: theme.copyWith(
                      textTheme: theme.textTheme.copyWith(
                        bodyMedium: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    element: state.book!.headerLeft!,
                    fontFamily: state.fontType.familyName,
                    fontSize: state.getFontSize(theme) + 2,
                  ),
                ),
              ),
            ),
          if (state.book!.headerRight != null)
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: buildReaderBase(
                    theme: Theme.of(context),
                    element: state.book!.headerRight!,
                    fontFamily: state.fontType.familyName,
                    fontSize: state.getFontSize(theme) - 2,
                  ),
                ),
                textAlign: TextAlign.end,
              ),
            ),
        ],
      ),
    );
  }
}
