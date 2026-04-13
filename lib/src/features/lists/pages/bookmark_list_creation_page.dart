import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/features/bookmarks/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/features/catalogue/widgets/list_creation_mode_controls.dart';
import 'package:wolnelektury/src/features/common/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/bookmarks/my_library_bookmarks_section.dart';

class BookmarkListCreationPage extends StatelessWidget {
  const BookmarkListCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BookmarksCubit(get.get())..getMyLibraryBookmarks();
      },
      child: BlocBuilder<AppModeCubit, AppModeState>(
        buildWhen: (p, c) => p.mode != c.mode,
        builder: (context, state) {
          return Stack(
            children: [
              const MyLibraryBookmarksSection(),
              if (state.isListBookmarksCreation)
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ListCreationModeControls(),
                ),
            ],
          );
        },
      ),
    );
  }
}
