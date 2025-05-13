import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_bookmark_listener.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_list_view_builder.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/settings/reading_page_settings.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPage extends StatefulWidget {
  final BookModel? book;
  const ReadingPage({super.key, required this.book});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.book == null) {
      return const Center(child: Text('Error'));
    }

    return BlocProvider(
      create: (context) => ReadingPageCubit(
        get.get(),
        get.get(),
        get.get(),
      )..init(book: widget.book!, itemScrollController: itemScrollController),
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<ReadingPageCubit>(context);
          return ReaderBookmarkListener(
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
        },
      ),
    );
  }
}
