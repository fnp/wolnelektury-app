import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookmarkWidget extends StatelessWidget {
  final BookModel book;
  final BookmarkModel bookmark;
  final bool isLoading;
  const BookmarkWidget({
    super.key,
    required this.bookmark,
    required this.book,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
    return BlocBuilder<BookmarksCubit, BookmarksState>(
      buildWhen: (p, c) {
        return p.bookmarkToDelete != c.bookmarkToDelete ||
            p.bookmarkExists(bookmark.slug, bookmark.anchor) !=
                c.bookmarkExists(bookmark.slug, bookmark.anchor);
      },
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child:
              (state.bookmarkToDelete == bookmark ||
                      !state.bookmarkExists(bookmark.slug, bookmark.anchor)) &&
                  !isLoading
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.spacer),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: CustomColors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.mediumPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      book.title,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    book.authors.map((e) => e.name).join(', '),
                                    style: theme.textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: Dimensions.smallPadding,
                                children: [
                                  const Icon(CustomIcons.bookmark),
                                  CustomButton(
                                    onPressed: () {
                                      bookmarkCubit.deleteBookmark(
                                        bookmark: bookmark,
                                      );
                                      CustomSnackbar.success(
                                        context,
                                        LocaleKeys.audio_dialog_delete_paragraph
                                            .tr(),
                                        onRevert: () {
                                          bookmarkCubit.undoDeletion();
                                        },
                                        messengerKey: AudioDialog.messengerKey,
                                      );
                                    },
                                    icon: CustomIcons.delete_forever,
                                    backgroundColor: CustomColors.red,
                                    iconColor: CustomColors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.mediumPadding),
                          SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: CustomColors.black),
                                  right: BorderSide(color: CustomColors.black),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.mediumPadding,
                                  horizontal: Dimensions.veryLargePadding,
                                ),
                                child: Text(
                                  LocaleKeys.audio_dialog_paragraph.tr(
                                    namedArgs: {
                                      'paragraph': (bookmark.anchor).toString(),
                                    },
                                  ),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: CustomColors.lightGrey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: Dimensions.mediumPadding,
                                  bottom: Dimensions.mediumPadding,
                                  right: Dimensions.mediumPadding,
                                  left: Dimensions.veryLargePadding,
                                ),
                                child: _Note(note: bookmark.note),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.mediumPadding),
                          Row(
                            spacing: Dimensions.mediumPadding,
                            children: [
                              Flexible(
                                child: TextButtonWithIcon(
                                  onPressed: () {
                                    //TODO: Implement bookmark read from functionality
                                  },
                                  nonActiveText: LocaleKeys
                                      .common_icon_button_read
                                      .tr(),
                                  nonActiveIcon: CustomIcons.book_5,
                                ),
                              ),
                              Flexible(
                                child: TextButtonWithIcon(
                                  onPressed: () {
                                    //TODO: Implement bookmark listen from functionality
                                  },
                                  nonActiveText: LocaleKeys
                                      .common_icon_button_listen
                                      .tr(),
                                  nonActiveIcon: CustomIcons.headphones,
                                ),
                              ),
                              CustomButton(
                                onPressed: () {
                                  //TODO: Implement bookmark share functionality
                                },
                                icon: CustomIcons.ios_share,
                                iconColor: CustomColors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _Note extends StatefulWidget {
  final String note;
  const _Note({required this.note});

  @override
  State<_Note> createState() => _NoteState();
}

class _NoteState extends State<_Note> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.note,
            style: theme.textTheme.bodyMedium,
            maxLines: isExpanded ? null : 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Icon(
          CustomIcons.stylus_note,
          color: CustomColors.black,
          size: 22,
        ),
      ],
    );
  }
}
