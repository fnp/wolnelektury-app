import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_search_service.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/data/search_repository.dart';
import 'package:wolnelektury/src/presentation/cubits/search/search_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_bar.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_hints.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_results.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        get.get<SearchRepository>(),
        get.get<AppStorageSearchService>(),
      ),
      child: Builder(
        builder: (context) {
          final searchCubit = context.read<SearchCubit>();
          final theme = Theme.of(context);
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.mediumPadding,
              vertical: Dimensions.spacer,
            ),
            child: Column(
              children: [
                SearchBar(
                  onChanged: (value) {
                    searchCubit.changeQuery(value);
                  },
                  onClear: () {
                    searchCubit.changeQuery('');
                  },
                ),
                const SizedBox(height: Dimensions.mediumPadding),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (p, c) {
                    return p.showResults != c.showResults;
                  },
                  builder: (context, state) {
                    if (state.showResults) {
                      return const SizedBox.shrink();
                    }
                    return const Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SearchHints()],
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (p, c) {
                    return p.showResults != c.showResults;
                  },
                  builder: (context, state) {
                    if (!state.showResults) {
                      return const SizedBox.shrink();
                    }
                    return Expanded(
                      child: AnimatedBoxFade(
                        isChildVisible: state.showResults,
                        child: const SearchResults(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: Dimensions.mediumPadding),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (p, c) {
                    return p.showResults != c.showResults ||
                        p.query != c.query ||
                        (c.query?.isNotEmpty ?? false);
                  },
                  builder: (context, state) {
                    return AnimatedBoxFade(
                      isChildVisible:
                          !state.showResults &&
                          state.query != null &&
                          state.query!.isNotEmpty,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<SearchCubit>().toggleShowResults(
                                  true,
                                );
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              style: greenElevatedButton,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  LocaleKeys.search_show_all.tr(),
                                  style: theme.textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: Dimensions.spacer),
              ],
            ),
          );
        },
      ),
    );
  }
}
