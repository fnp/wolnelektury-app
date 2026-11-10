import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/enums/my_library_enum.dart';
import 'package:wolnelektury/src/features/common/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/common/widgets/page_subtitle.dart';
import 'package:wolnelektury/src/features/my_library/widgets/quotes/my_library_quote_element.dart';
import 'package:wolnelektury/src/features/readers/cubits/quotes/quotes_cubit.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class MyLibraryQuotesSection extends StatelessWidget {
  const MyLibraryQuotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageSubtitle(subtitle: MyLibraryEnum.quotes.title),
          Expanded(
            child: BlocBuilder<QuotesCubit, QuotesState>(
              buildWhen: (p, c) {
                return p.isLoading != c.isLoading ||
                    p.quotes.isNotEmpty && c.quotes.isEmpty ||
                    p.quotes.isEmpty && c.quotes.isNotEmpty;
              },
              builder: (context, state) {
                return AnimatedSwitcher(
                  switchInCurve: defaultCurve,
                  switchOutCurve: defaultCurve,
                  duration: const Duration(milliseconds: 300),
                  child: !state.isLoading && state.quotes.isEmpty
                      ? const _EmptyWidget()
                      : CustomScrollPage(
                          key: ValueKey(state.quotes.length),
                          onRefresh: () {
                            return cubit.getMyLibraryQuotes();
                          },
                          onLoadMore: () {
                            cubit.getMoreMyLibraryQuotes();
                          },
                          builder: (scrollController) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                return MyLibraryQuoteElement(
                                  key: ValueKey(state.quotes[index].uuid),
                                  quote: state.quotes[index],
                                );
                              },
                              itemCount: state.quotes.length,
                            );
                          },
                        ),
                );
              },
            ),
          ),
          BlocBuilder<AppModeCubit, AppModeState>(
            buildWhen: (p, c) {
              return p.mode != c.mode;
            },
            builder: (context, state) {
              if (state.isListQuotesCreation) {
                return const SizedBox(height: Dimensions.spacer * 3);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    return EmptyWidget(
      image: Images.empty,
      message: LocaleKeys.common_empty_quotes_title.tr(),
      buttonText: LocaleKeys.common_empty_search_in_catalogue.tr(),
      onTap: () {
        router.goNamed(cataloguePageConfig.name);
      },
      onRefresh: () {
        cubit.getMyLibraryQuotes();
      },
    );
  }
}
