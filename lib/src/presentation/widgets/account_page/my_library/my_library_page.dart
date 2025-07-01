import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/audiobooks/my_library_audiobooks_section.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/bookmarks/my_library_bookmarks_section.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/liked/my_library_liked_section.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/lists/my_library_lists_section.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/my_library_pill.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/readers/my_library_readers_section.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({super.key});

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();
  final AutoScrollController _scrollController = AutoScrollController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<ListCreatorCubit>()..init()),
        BlocProvider(
          create: (context) {
            return BookmarksCubit(get.get())..getMyLibraryBookmarks();
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimensions.largePadding),
          SizedBox(
            height: Dimensions.elementHeight,
            child: ListView.separated(
              controller: _scrollController,
              separatorBuilder: (_, __) {
                return const SizedBox(width: Dimensions.mediumPadding);
              },
              scrollDirection: Axis.horizontal,
              itemCount: MyLibraryEnum.values.length,
              itemBuilder: (_, index) {
                final isFirst = index == 0;
                final isLast = index == MyLibraryEnum.values.length - 1;
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: _scrollController,
                  index: index,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: isFirst ? Dimensions.mediumPadding : 0,
                      right: isLast ? Dimensions.mediumPadding : 0,
                    ),
                    child: MyLibraryPill(
                      isSelected: currentPageIndex == index,
                      pillType: MyLibraryEnum.values[index],
                      onTap: () {
                        setState(() {
                          currentPageIndex = index;
                        });
                        _pageController.jumpToPage(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentPageIndex = value;
                  _scrollController.scrollToIndex(
                    value,
                    preferPosition: AutoScrollPosition.end,
                  );
                });
              },
              controller: _pageController,
              children: const [
                MyLibraryListsSection(),
                MyLibraryLikedSection(),
                MyLibraryBookmarksSection(),
                MyLibraryAudiobooksSection(),
                MyLibraryReadersSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
