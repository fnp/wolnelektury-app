import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/presentation/widgets/common/connectivity_wrapper.dart';
import 'package:wolnelektury/src/utils/share/share_utils.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookmarkWidget extends StatelessWidget {
  final BookModel book;
  final BookmarkModel bookmark;
  final bool isLoading;
  final Color backgroundColor;
  final GlobalKey<ScaffoldMessengerState>? messengerKey;
  final Function(int? timestamp, bool isPlaying)? onListen;
  final bool isReaderAvailableOffline;
  final bool isAudioAvailableOffline;
  const BookmarkWidget({
    super.key,
    required this.bookmark,
    required this.book,
    required this.isLoading,
    required this.backgroundColor,
    this.isReaderAvailableOffline = false,
    this.isAudioAvailableOffline = false,
    this.onListen,
    this.messengerKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarksCubit, BookmarksState>(
      buildWhen: (p, c) {
        return p.bookmarkToDelete?.location != c.bookmarkToDelete?.location ||
            p.bookmarkExists(bookmark.slug, bookmark.location) !=
                c.bookmarkExists(bookmark.slug, bookmark.location);
      },
      builder: (context, state) {
        final shouldHide =
            (state.bookmarkToDelete?.location == bookmark.location ||
                !state.bookmarkExists(bookmark.slug, bookmark.location)) &&
            !isLoading;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          child: shouldHide
              ? const SizedBox(width: double.infinity)
              : _Body(
                  book: book,
                  bookmark: bookmark,
                  backgroundColor: backgroundColor,
                  messengerKey: messengerKey,
                  onListen: onListen,
                  isAudioAvailableOffline: isAudioAvailableOffline,
                  isReaderAvailableOffline: isReaderAvailableOffline,
                ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final BookModel book;
  final BookmarkModel bookmark;
  final Color backgroundColor;
  final GlobalKey<ScaffoldMessengerState>? messengerKey;
  final Function(int? timestamp, bool isPlaying)? onListen;
  final bool isReaderAvailableOffline;
  final bool isAudioAvailableOffline;
  const _Body({
    required this.book,
    required this.bookmark,
    required this.backgroundColor,
    this.isReaderAvailableOffline = false,
    this.isAudioAvailableOffline = false,
    this.messengerKey,
    this.onListen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.spacer),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: backgroundColor,
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            book.title,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            book.authors.map((e) => e.name).join(', '),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: CustomColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: Dimensions.smallPadding,
                    children: [
                      CustomButton(
                        onPressed: () {
                          bookmarkCubit.deleteBookmark(bookmark: bookmark);
                          CustomSnackbar.success(
                            context,
                            LocaleKeys.audio_dialog_delete_paragraph.tr(),
                            onRevert: () {
                              bookmarkCubit.undoDeletion();
                            },
                            messengerKey: messengerKey,
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
              if (bookmark.anchor != null)
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
                            'paragraph': (bookmark.anchor ?? '').toString(),
                          },
                        ),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.inverseSurface,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
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
              ConnectivityWrapper(
                builder: (context, hasConnection) {
                  final isReadingAvailable =
                      bookmark.anchor != null &&
                      (hasConnection || isReaderAvailableOffline);

                  final isListeningAvailable =
                      bookmark.audioTimestamp != null &&
                      (hasConnection || isAudioAvailableOffline);
                  return Row(
                    spacing: Dimensions.mediumPadding,
                    children: [
                      Flexible(
                        child: Opacity(
                          opacity: isReadingAvailable ? 1.0 : 0.5,
                          child: IgnorePointer(
                            ignoring: !isReadingAvailable,
                            child: TextButtonWithIcon(
                              onPressed: () {
                                if (messengerKey != null) {
                                  Navigator.of(context).pop();
                                }
                                router.pushNamed(
                                  readingPageConfigWithAnchor.name,
                                  extra: book,
                                  pathParameters: {
                                    'slug': book.slug,
                                    if (bookmark.anchor != null)
                                      'anchor': bookmark.anchor!,
                                  },
                                );
                              },
                              nonActiveText: LocaleKeys.common_icon_button_read
                                  .tr(),
                              nonActiveIcon: CustomIcons.book_5,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Opacity(
                          opacity: isListeningAvailable ? 1.0 : 0.5,
                          child: IgnorePointer(
                            ignoring: !isListeningAvailable,
                            child: BlocBuilder<AudioCubit, AudioState>(
                              buildWhen: (p, c) => p.isPlaying != c.isPlaying,
                              builder: (context, state) {
                                return TextButtonWithIcon(
                                  onPressed: () {
                                    onListen?.call(
                                      bookmark.audioTimestamp,
                                      state.isPlaying,
                                    );
                                  },
                                  nonActiveText: LocaleKeys
                                      .common_icon_button_listen
                                      .tr(),
                                  nonActiveIcon: CustomIcons.headphones,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        onPressed: () {
                          ShareUtils.shareBookmark(bookmark);
                        },
                        icon: CustomIcons.ios_share,
                        iconColor: CustomColors.black,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
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
        Icon(
          CustomIcons.stylus_note,
          color: theme.colorScheme.onPrimary,
          size: 22,
        ),
      ],
    );
  }
}
