import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/offline/offline_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/connectivity_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/empty_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/readers/my_library_reader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class MyLibraryReadersSection extends StatelessWidget {
  const MyLibraryReadersSection({super.key});

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
                PageSubtitle(subtitle: MyLibraryEnum.readers.title),
                Expanded(
                  // This is needed to refresh offline books data after finishing download
                  child: BlocListener<DownloadCubit, DownloadState>(
                    listenWhen: (p, c) {
                      return p.downloadingBookReaderSlug != null &&
                          c.downloadingBookReaderSlug == null;
                    },
                    listener: (context, state) {
                      offlineCubit.loadOfflineBooks();
                    },
                    child: BlocBuilder<OfflineCubit, OfflineState>(
                      buildWhen: (p, c) {
                        return p.isLoading != c.isLoading ||
                            p.readers.isNotEmpty && c.readers.isEmpty;
                      },
                      builder: (context, state) {
                        if (!state.isLoading && state.readers.isEmpty) {
                          //todo translations
                          return ConnectivityWrapper(
                            builder: (context, hasConnection) {
                              return EmptyWidget(
                                image: Images.empty,
                                message: 'Nie zapisano jeszcze żadnych książek',
                                buttonText: 'Przeglądaj katalog',
                                onTap: () {
                                  router.goNamed(cataloguePageConfig.name);
                                },
                                hasConnection: hasConnection,
                              );
                            },
                          );
                        }
                        return CustomScrollPage(
                          builder: (scrollController) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                return MyLibraryReader(
                                  offlineBook: state.readers[index],
                                );
                              },
                              itemCount: state.readers.length,
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
