import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/enums/my_library_enum.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/common/widgets/page_subtitle.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/lists/widgets/book_lists_create_widget.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_lists_section_listener.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class MyLibraryListsSection extends StatelessWidget {
  const MyLibraryListsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final listCubit = context.read<ListCreatorCubit>();
    return BlocProvider.value(
      value: listCubit..getLists(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.mediumPadding,
        ),
        child: MyLibraryListsSectionListener(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageSubtitle(subtitle: MyLibraryEnum.lists.title),
              BookListsCreateWidget(
                onSave: (text) {
                  listCubit.addEmptyList(name: text);
                },
              ),
              const SizedBox(height: Dimensions.spacer),
              Expanded(
                child: CustomScrollPage(
                  onRefresh: () {
                    return listCubit.getLists(force: true);
                  },
                  onLoadMore: () {
                    listCubit.getMoreLists();
                  },
                  builder: (scrollController) {
                    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
                      buildWhen: (p, c) {
                        return p.isLoading != c.isLoading ||
                            p.isAdding != c.isAdding ||
                            p.pendingList != c.pendingList ||
                            p.allLists.isNotEmpty && c.allLists.isEmpty ||
                            p.allLists.isEmpty && c.allLists.isNotEmpty;
                      },
                      builder: (context, state) {
                        final isPending = state.pendingList != null;
                        final effLength = state.isAdding
                            ? state.allLists.length + 1
                            : state.allLists.length;

                        if (!state.isLoading && state.allLists.isEmpty) {
                          return EmptyWidget(
                            image: Images.empty,
                            message: LocaleKeys.common_empty_lists_title.tr(),
                            onRefresh: () {
                              listCubit.getLists(force: true);
                            },
                          );
                        }

                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: scrollController,
                          itemCount: effLength,
                          itemBuilder: (context, index) {
                            if (index == 0 && state.isAdding) {
                              return AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: defaultCurve,
                                child: isPending
                                    ? MyLibraryList(
                                        bookList: state.pendingList!,
                                        isCompact: true,
                                      )
                                    : const SizedBox(),
                              );
                            }

                            final effIndex = state.isAdding ? index - 1 : index;

                            return MyLibraryList(
                              key: ValueKey(state.allLists[effIndex].slug),
                              bookList: state.allLists[effIndex],
                              isCompact: true,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
