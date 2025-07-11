import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/connectivity_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/audiobooks/my_library_audiobooks_section.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/bookmarks/my_library_bookmarks_section.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/liked/my_library_liked_section.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/lists/my_library_lists_section.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/login/my_library_login_forms.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/my_library_pill.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/readers/my_library_readers_section.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({super.key});

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) {
        return p.isAuthenticated != c.isAuthenticated;
      },
      builder: (context, authState) {
        return ConnectivityWrapper(
          key: (ValueKey(authState.isAuthenticated)),
          builder: (context, hasConnection) {
            List<MyLibraryEnum> myLibraryEnums = (hasConnection)
                ? (authState.isAuthenticated
                      ? availableOnlineAuthEnums
                      : availableOnlineNoAuthEnums)
                : (authState.isAuthenticated
                      ? availableOfflineEnums
                      : availableOnlineNoAuthEnums);

            return _Body(
              myLibraryEnums: myLibraryEnums,
              hasConnection: hasConnection,
              isAuth: authState.isAuthenticated,
            );
          },
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  final List<MyLibraryEnum> myLibraryEnums;
  final bool hasConnection;
  final bool isAuth;
  const _Body({
    required this.myLibraryEnums,
    required this.hasConnection,
    required this.isAuth,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
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
              itemCount: widget.myLibraryEnums.length,

              itemBuilder: (_, index) {
                final isFirst = index == 0;
                final isLast = index == widget.myLibraryEnums.length - 1;
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
                      pillType: widget.myLibraryEnums[index],
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
                  if (widget.hasConnection && widget.isAuth) ...[
                    const MyLibraryListsSection(),
                    const MyLibraryLikedSection(),
                    const MyLibraryBookmarksSection(),
                  ],
                  const MyLibraryAudiobooksSection(),
                  const MyLibraryReadersSection(),
                  if (!widget.isAuth) const MyLibraryMyLibraryLoginForms(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
