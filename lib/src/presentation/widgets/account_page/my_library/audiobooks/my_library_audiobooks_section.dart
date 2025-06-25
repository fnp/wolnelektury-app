import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/audiobooks/my_library_audiobook.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryAudiobooksSection extends StatelessWidget {
  const MyLibraryAudiobooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageSubtitle(subtitle: MyLibraryEnum.audiobooks.title),
          Expanded(
            child: BlocBuilder<OfflineCubit, OfflineState>(
              buildWhen: (p, c) => p.isLoading != c.isLoading,
              builder: (context, state) {
                return CustomScrollPage(
                  builder: (scrollController) {
                    return ListView.builder(
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return MyLibraryAudiobook(
                          offlineBook: state.books[index],
                        );
                      },
                      itemCount: state.books.length,
                    );
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
