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
  final bool isOfflineMode;
  const MyLibraryPage({super.key, required this.isOfflineMode});

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  int currentPageIndex = 0;
  double _opacity = 1;
  final PageController _pageController = PageController();
  final AutoScrollController _scrollController = AutoScrollController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final efectiveEnums = widget.isOfflineMode
        ? MyLibraryEnum.values
              .where((element) => element.isAvailableOffline)
              .toList()
        : MyLibraryEnum.values;
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
              itemCount: efectiveEnums.length,

              itemBuilder: (_, index) {
                final isFirst = index == 0;
                final isLast = index == efectiveEnums.length - 1;
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
                      pillType: efectiveEnums[index],
                      onTap: () async {
                        setState(() {
                          currentPageIndex = index;
                          _opacity = 0;
                        });
                        // Delay to allow the opacity animation to start
                        // This decreases the flickering effect a lot
                        await Future.delayed(
                          const Duration(milliseconds: 200),
                        ).then((_) {
                          _pageController.jumpToPage(index);
                          setState(() {
                            _opacity = 1;
                          });
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              opacity: _opacity,
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
                children: [
                  if (!widget.isOfflineMode) ...[
                    const MyLibraryListsSection(),
                    const MyLibraryLikedSection(),
                    const MyLibraryBookmarksSection(),
                  ],
                  const MyLibraryAudiobooksSection(),
                  const MyLibraryReadersSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
