import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPageParagraphSheet extends StatelessWidget {
  const ReadingPageParagraphSheet({super.key});

  static void show({
    required BuildContext context,
    VoidCallback? onClosed,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      backgroundColor: CustomColors.primaryYellowColor,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<ReadingPageCubit>(),
          ),
        ],
        child: const ReadingPageParagraphSheet(),
      ),
    ).then((_) {
      onClosed?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReadingPageCubit>(context);
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: BlocConsumer<ReadingPageCubit, ReadingPageState>(
        listenWhen: (p, c) => p.isBookmarkSuccess != c.isBookmarkSuccess,
        listener: (context, state) {
          if (state.isBookmarkSuccess != null &&
              state.isBookmarkSuccess!.$2 == true) {
            cubit.toggleIsAddingBookmark();
            cubit.selectParagraph();
            Navigator.of(context).pop();
          }
        },
        buildWhen: (p, c) => p.isAddingBookmark != c.isAddingBookmark,
        builder: (context, state) {
          return AnimatedBoxFade(
            isChildVisible: !state.isAddingBookmark,
            collapsedChild: const _BookmarkNote(),
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.mediumPadding),
                child: Column(
                  spacing: Dimensions.mediumPadding,
                  children: [
                    TextButtonWithIcon(
                      nonActiveText: 'przetłumacz (todo)',
                      nonActiveIcon: Icons.translate,
                      onPressed: () {},
                      activeColor: CustomColors.white,
                    ),
                    TextButtonWithIcon(
                      nonActiveText: LocaleKeys.reading_sheet_bookmark_add.tr(),
                      nonActiveIcon: Icons.bookmark_add_rounded,
                      onPressed: () {
                        final authCubit = BlocProvider.of<AuthCubit>(context);
                        if (authCubit.state.user == null) {
                          return CustomSnackbar.error(
                            context,
                            LocaleKeys.common_snackbar_not_logged.tr(),
                          );
                        }

                        cubit.toggleIsAddingBookmark();
                        final isBookmarked =
                            state.isSelectedParagraphBookmarked;
                        cubit.setEditingBookmark(isBookmarked);
                      },
                      activeColor: CustomColors.white,
                    ),
                    TextButtonWithIcon(
                      nonActiveText: 'zapisz cytat',
                      nonActiveIcon: Icons.format_quote_rounded,
                      onPressed: () {},
                      activeColor: CustomColors.white,
                    ),
                    TextButtonWithIcon(
                      nonActiveText: 'słuchaj',
                      nonActiveIcon: Icons.headphones,
                      onPressed: () {},
                      activeColor: CustomColors.white,
                    ),
                    TextButtonWithIcon(
                      nonActiveText: 'udostępnij',
                      nonActiveIcon: Icons.ios_share,
                      onPressed: () {},
                      activeColor: CustomColors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BookmarkNote extends StatefulWidget {
  const _BookmarkNote();

  @override
  State<_BookmarkNote> createState() => _BookmarkNoteState();
}

class _BookmarkNoteState extends State<_BookmarkNote> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<ReadingPageCubit>(context);
    if (cubit.state.editingBookmark != null) {
      _controller.text = cubit.state.editingBookmark?.note ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReadingPageCubit>(context);
    final isEditing = cubit.state.editingBookmark != null;
    final theme = Theme.of(context);
    final inputPadding = theme.inputDecorationTheme.contentPadding;
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Dimensions.mediumPadding,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  icon: isEditing ? Icons.delete_forever : Icons.arrow_back,
                  iconColor:
                      isEditing ? CustomColors.white : CustomColors.black,
                  backgroundColor:
                      isEditing ? CustomColors.red : CustomColors.white,
                  onPressed: () {
                    if (isEditing) {
                      cubit.deleteBookmark();
                      return;
                    }
                    cubit.toggleIsAddingBookmark();
                  },
                ),
                const Spacer(),
                Flexible(
                  child: TextButtonWithIcon(
                    nonActiveText: isEditing
                        ? LocaleKeys.reading_sheet_bookmark_edit.tr()
                        : LocaleKeys.reading_sheet_bookmark_add.tr(),
                    nonActiveIcon: Icons.bookmark_add_rounded,
                    activeColor: CustomColors.white,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Stack(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: (inputPadding?.horizontal ?? 0) / 2,
                        right: Dimensions.elementHeight +
                            ((inputPadding?.horizontal ?? 0) / 2),
                        top: (inputPadding?.vertical ?? 0) / 2,
                        bottom: (inputPadding?.vertical ?? 0) / 2,
                      ),
                    ),
                    maxLines: 5,
                    minLines: 5,
                  ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CustomButton(
                      icon: CustomIcons.stylus_note,
                      backgroundColor: CustomColors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CustomButton(
                      icon: isEditing ? Icons.check : Icons.add,
                      backgroundColor: CustomColors.green,
                      onPressed: () {
                        if (isEditing) {
                          cubit.updateBookmark(
                            note: _controller.text.trim(),
                          );
                          return;
                        }

                        final anchorId =
                            cubit.state.selectedParagraph?.paragraphIndex;
                        if (anchorId == null ||
                            cubit.state.currentSlug == null) {
                          return;
                        }
                        cubit.createBookmark(
                          anchorId: anchorId,
                          note: _controller.text.trim(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
