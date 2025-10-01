import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_bookmark_listener.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_list_view_builder.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPage extends StatefulWidget {
  final BookModel? book;
  final String? slug;
  final int? overrideProgressAnchor;
  const ReadingPage({
    super.key,
    this.book,
    this.slug,
    this.overrideProgressAnchor,
  }) : assert(
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
                overrideProgressAnchor: widget.overrideProgressAnchor,
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
            create: (context) =>
                SingleBookCubit(get.get(), get.get())..loadBookData(
                  slug: slug!,
                  onFinished: (book) {
                    context.read<ReadingPageCubit>().init(
                      book: book,
                      itemScrollController: itemScrollController,
                      overrideProgressAnchor: widget.overrideProgressAnchor,
                      tryOffline: !hasConnection,
                      scaleFactor: scaleFactor,
                    );
                  },
                ),
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
    return BookmarkListener(
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
                    child: CustomLoader(color: CustomColors.secondaryBlueColor),
                  ),
                  child: state.book == null
                      ? const SizedBox.shrink()
                      : ReaderListViewBuilder(
                          state: state,
                          itemScrollController: itemScrollController,
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
  }
}
