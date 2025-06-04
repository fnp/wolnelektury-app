import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/liked/my_library_liked_section.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/lists/my_library_lists_section.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/my_library_pill.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({super.key});

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  Timer? _debounce;
  bool _canTrigger = true;
  final verticalController = AutoScrollController();
  final horizontalController = AutoScrollController();

  int currentIndex = 0;

  void setIndex({required int newIndex, required bool shouldScrollVertically}) {
    if (currentIndex == newIndex) {
      return;
    }
    setState(() {
      currentIndex = newIndex;
    });

    horizontalController.scrollToIndex(
      newIndex,
      preferPosition: AutoScrollPosition.middle,
    );

    if (!shouldScrollVertically) {
      return;
    }

    verticalController.scrollToIndex(
      newIndex,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  bool isIndexActive(int index) => currentIndex == index;
  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ListCreatorCubit>()..init(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimensions.largePadding),
          SizedBox(
            height: Dimensions.elementHeight,
            child: ListView.separated(
              separatorBuilder: (_, __) =>
                  const SizedBox(width: Dimensions.mediumPadding),
              controller: horizontalController,
              scrollDirection: Axis.horizontal,
              itemCount: MyLibraryEnum.values.length,
              itemBuilder: (_, index) {
                final isFirst = index == 0;
                final isLast = index == MyLibraryEnum.values.length - 1;
                return Padding(
                  padding: EdgeInsets.only(
                    left: isFirst ? Dimensions.mediumPadding : 0,
                    right: isLast ? Dimensions.mediumPadding : 0,
                  ),
                  child: AutoScrollTag(
                    key: ValueKey(index),
                    controller: horizontalController,
                    index: index,
                    child: MyLibraryPill(
                      isSelected: isIndexActive(index),
                      pillType: MyLibraryEnum.values[index],
                      onTap: () {
                        _canTrigger = false;

                        setIndex(newIndex: index, shouldScrollVertically: true);

                        _debounce?.cancel();
                        _debounce = Timer(
                          const Duration(milliseconds: 300),
                          () {
                            _canTrigger = true;
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: Dimensions.largePadding),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
              ),
              child: CustomScrollPage(
                controller: verticalController,
                builder: (controller) => ListView.builder(
                  controller: controller,
                  itemCount: MyLibraryEnum.values.length,
                  itemBuilder: (_, index) {
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: verticalController,
                      index: index,
                      child: VisibilityDetector(
                        key: ValueKey(index),
                        onVisibilityChanged: (visibilityInfo) {
                          if (visibilityInfo.visibleFraction > 0 &&
                              _canTrigger) {
                            _canTrigger = false;
                            setIndex(
                              newIndex: index,
                              shouldScrollVertically: false,
                            );

                            _debounce?.cancel();
                            _debounce = Timer(
                              const Duration(milliseconds: 300),
                              () {
                                _canTrigger = true;
                              },
                            );
                          }
                        },
                        child: _WidgetByType(type: MyLibraryEnum.values[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetByType extends StatelessWidget {
  final MyLibraryEnum type;
  const _WidgetByType({required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MyLibraryEnum.audiobooks:
        return const Center(
          child: SizedBox(height: 800, child: Text('Audiobooks Section')),
        );
      case MyLibraryEnum.lists:
        return const MyLibraryListsSection();
      case MyLibraryEnum.liked:
        return const MyLibraryLikedSection();
      case MyLibraryEnum.bookmarks:
        return const Center(
          child: SizedBox(height: 800, child: Text('Bookmarks Section')),
        );
    }
  }
}
