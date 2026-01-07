import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/enums/my_library_enum.dart';
import 'package:wolnelektury/src/features/common/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/connectivity_wrapper.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/common/widgets/page_subtitle.dart';
import 'package:wolnelektury/src/features/my_library/widgets/audiobooks/my_library_audiobook.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class MyLibraryAudiobooksSection extends StatelessWidget {
  const MyLibraryAudiobooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
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
                        return ConnectivityWrapper(
                          builder: (context, hasConnection) {
                            return EmptyWidget(
                              image: Images.empty,
                              message: LocaleKeys.common_empty_audiobooks_title
                                  .tr(),
                              buttonText: LocaleKeys
                                  .common_empty_search_in_catalogue
                                  .tr(),
                              onTap: () {
                                router.goNamed(cataloguePageConfig.name);
                              },
                              hasConnection: hasConnection,
                              onRefresh: () {
                                offlineCubit.loadOfflineBooks();
                              },
                            );
                          },
                        );
                      }
                      return CustomScrollPage(
                        onRefresh: () {
                          return offlineCubit.loadOfflineBooks();
                        },
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
    );
  }
}
