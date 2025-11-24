import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_bookmark_listener.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_list_view_builder.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_page_progress_indicator.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPage extends StatefulWidget {
  final BookModel? book;
  final String? slug;
  final String? targetAnchor;
  const ReadingPage({super.key, this.book, this.slug, this.targetAnchor})
    : assert(
        book != null || slug != null,
        'Either book or slug must be provided',
      );

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final slug = widget.slug ?? widget.book?.slug;
    final child = _Body(itemScrollController: itemScrollController);
    final hasConnection = context.read<ConnectivityCubit>().state.isConnected;
    final scaleFactor = MediaQuery.textScalerOf(context).scale(1);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = ReadingPageCubit(get.get(), get.get(), get.get());
            if (widget.book != null) {
              cubit.init(
                book: widget.book!,
                itemScrollController: itemScrollController,
                targetAnchor: widget.targetAnchor,
                tryOffline: !hasConnection,
                scaleFactor: scaleFactor,
              );
            }
            return cubit;
          },
        ),
        BlocProvider(
          lazy: false,
          create: (context) {
            return BookmarksCubit(get.get())..getBookBookmarks(slug: slug!);
          },
        ),
        if (widget.book == null)
          BlocProvider(
            lazy: false,
            create: (context) {
              return SingleBookCubit(get.get(), get.get())..getBookData(
                slug: slug!,
                onFinished: (book, isOffline) {
                  context.read<ReadingPageCubit>().init(
                    book: book,
                    itemScrollController: itemScrollController,
                    targetAnchor: widget.targetAnchor,
                    tryOffline: isOffline,
                    scaleFactor: scaleFactor,
                  );
                },
              );
            },
          ),
      ],
      child: child,
    );
  }
}

class _Body extends StatelessWidget {
  final ItemScrollController itemScrollController;
  const _Body({required this.itemScrollController});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReadingPageCubit>(context);
    return BlocListener<ReadingPageCubit, ReadingPageState>(
      listenWhen: (p, c) {
        return !p.isJsonLoadingError && c.isJsonLoadingError;
      },
      listener: (context, state) {
        CustomSnackbar.error(
          context,
          LocaleKeys.reading_snackbar_reader_loading_error.tr(),
        );
      },
      child: BookmarkListener(
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocBuilder<ReadingPageCubit, ReadingPageState>(
                buildWhen: (p, c) => c.shouldRebuild(p),
                builder: (context, state) {
                  return AnimatedBoxFade(
                    duration: const Duration(milliseconds: 400),
                    isChildVisible: !state.isJsonLoading,
                    collapsedChild: const _SkeletonPlaceholder(),
                    child: state.book == null
                        ? const SizedBox.shrink()
                        : _HighlightedParagraphListener(
                            bookSlug: state.currentSlug,
                            itemScrollController: itemScrollController,
                            child: ReaderListViewBuilder(
                              state: state,
                              itemScrollController: itemScrollController,
                            ),
                          ),
                  );
                },
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ReadingPageProgressIndicator(),
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
                    slug: cubit.state.currentSlug!,
                    onClosed: () {
                      cubit.saveSettings();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonPlaceholder extends StatelessWidget {
  const _SkeletonPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.largePadding * 2),
        child: SingleChildScrollView(
          child: Column(
            spacing: Dimensions.largePadding,
            children: [
              Text(BoneMock.longParagraph),
              Text(BoneMock.paragraph),
              Text(BoneMock.longParagraph),
              Text(BoneMock.longParagraph),
              Text(BoneMock.paragraph),
              Text(BoneMock.paragraph),
              Text(BoneMock.longParagraph),
            ],
          ),
        ),
      ),
    );
  }
}

class _HighlightedParagraphListener extends StatelessWidget {
  final ItemScrollController itemScrollController;
  final String? bookSlug;
  final Widget child;
  const _HighlightedParagraphListener({
    required this.itemScrollController,
    required this.child,
    this.bookSlug,
  });

  @override
  Widget build(BuildContext context) {
    final readingCubit = context.read<ReadingPageCubit>();
    return BlocSelector<ReadingPageCubit, ReadingPageState, bool>(
      selector: (state) {
        return state.isEnabledHighlighting;
      },
      builder: (context, isEnabled) {
        return MultiBlocListener(
          listeners: [
            BlocListener<AudioCubit, AudioState>(
              listenWhen: (p, c) {
                return c.book?.slug == bookSlug &&
                    p.statePosition != c.statePosition &&
                    c.statePosition % 3 == 0;
              },
              listener: (context, state) {
                readingCubit.highlightParagraph(
                  itemScrollController: itemScrollController,
                  audioTimestamp: state.statePosition,
                );
              },
            ),
            BlocListener<AudioCubit, AudioState>(
              listenWhen: (p, c) {
                return p.isPlaying != c.isPlaying;
              },
              listener: (context, state) {
                if (!state.isPlaying) {
                  readingCubit.stopHighlighting();
                }
              },
            ),
          ],
          child: child,
        );
      },
    );
  }
}
