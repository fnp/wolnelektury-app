import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/empty_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/audiobooks/my_library_audiobook.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class MyLibraryAudiobooksSection extends StatelessWidget {
  const MyLibraryAudiobooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OfflineCubit(get.get())..loadOfflineBooks();
      },
      child: Builder(
        builder: (context) {
          final offlineCubit = BlocProvider.of<OfflineCubit>(context);
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.mediumPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PageSubtitle(subtitle: MyLibraryEnum.audiobooks.title),
                Expanded(
                  // This is needed to refresh offline books data after finishing download
                  child: BlocListener<DownloadCubit, DownloadState>(
                    listenWhen: (p, c) {
                      return p.downloadingBookAudiobookSlug != null &&
                          c.downloadingBookAudiobookSlug == null;
                    },
                    listener: (context, state) {
                      offlineCubit.loadOfflineBooks();
                    },
                    child: BlocBuilder<OfflineCubit, OfflineState>(
                      buildWhen: (p, c) {
                        return p.isLoading != c.isLoading ||
                            p.audiobooks.isNotEmpty && c.audiobooks.isEmpty;
                      },
                      builder: (context, state) {
                        if (!state.isLoading && state.audiobooks.isEmpty) {
                          //todo translations
                          return EmptyWidget(
                            image: Images.empty,
                            message: 'Nie zapisano jeszcze żadnych audiobooków',
                            buttonText: 'Przeglądaj katalog',
                            onTap: () {
                              router.goNamed(cataloguePageConfig.name);
                            },
                          );
                        }
                        return CustomScrollPage(
                          builder: (scrollController) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                return MyLibraryAudiobook(
                                  offlineBook: state.audiobooks[index],
                                );
                              },
                              itemCount: state.audiobooks.length,
                            );
                          },
                        );
                      },
                    ),
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
