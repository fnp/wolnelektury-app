import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/progress/progress_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/empty_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/presentation/widgets/last_read/last_read_book_element.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class LastReadPage extends StatelessWidget {
  static const EdgeInsets _padding = EdgeInsets.all(Dimensions.mediumPadding);
  const LastReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgressCubit(get.get())..getProgresses(),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageSubtitle(subtitle: LocaleKeys.last_read_title.tr()),
              Expanded(
                child: CustomScrollPage(
                  onLoadMore: () {
                    BlocProvider.of<ProgressCubit>(context).loadMore();
                  },
                  builder: (controller) {
                    return BlocBuilder<ProgressCubit, ProgressState>(
                      buildWhen: (p, c) {
                        return p.progresses != c.progresses ||
                            p.isLoading != c.isLoading;
                      },
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const _SkeletonizedView();
                        }

                        if (!state.isLoading && state.progresses.isEmpty) {
                          //todo translations
                          return EmptyWidget(
                            image: Images.empty,
                            message: 'Nie czytano jeszcze żadnych książek',
                            buttonText: 'Przeglądaj katalog',
                            onTap: () {
                              router.goNamed(cataloguePageConfig.name);
                            },
                          );
                        }

                        return ListView.separated(
                          padding: _padding,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: Dimensions.spacer);
                          },
                          controller: controller,
                          itemCount: state.progresses.length,
                          itemBuilder: (context, index) {
                            final element = state.progresses[index];
                            return LastReadBookElement(slug: element.slug);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SkeletonizedView extends StatelessWidget {
  const _SkeletonizedView();

  @override
  Widget build(BuildContext context) {
    final List<BookModel> list = List.generate(3, (index) => BookModel.empty());

    return Skeletonizer(
      child: ListView.separated(
        padding: LastReadPage._padding,
        separatorBuilder: (context, index) {
          return const SizedBox(height: Dimensions.spacer);
        },
        itemCount: list.length,
        itemBuilder: (context, index) {
          return BookPageCoverWithButtons(book: list[index]);
        },
      ),
    );
  }
}
