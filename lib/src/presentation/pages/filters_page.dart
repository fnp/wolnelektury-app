import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_bar.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FilteringCubit>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<FilteringCubit>()..getTags()),
      ],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
            vertical: Dimensions.spacer,
          ),
          child: BlocBuilder<FilteringCubit, FilteringState>(
            // This triggers the load more if there's not enough items to fill the screen
            buildWhen: (p, c) => p.tags != c.tags,
            builder: (context, state) {
              return CustomScrollPage(
                onLoadMore: () {
                  cubit.loadMore();
                },
                builder: (controller) {
                  return CustomScrollView(
                    controller: controller,
                    slivers: [
                      SliverToBoxAdapter(
                        child: SearchBar(
                          initialValue: state.query,
                          onChanged: (value) {
                            cubit.changeQuery(value);
                          },
                          onClear: () {
                            cubit.changeQuery('');
                          },
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: Dimensions.mediumPadding),
                      ),
                      SliverStickyHeader(
                        overlapsContent: false,
                        header: const _SelectedTags(),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: Dimensions.mediumPadding),
                      ),
                      const _FilteringChips(),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SelectedTags extends StatelessWidget {
  const _SelectedTags();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilteringCubit>();
    final theme = Theme.of(context);

    return BlocBuilder<FilteringCubit, FilteringState>(
      buildWhen: (p, c) => p.selectedTags != c.selectedTags,
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Wrap(
            key: ValueKey(state.selectedTags.length),
            spacing: Dimensions.mediumPadding,
            runSpacing: 0,
            children: [
              ...state.selectedTags.mapIndexed((index, tag) {
                return ChoiceChip(
                  label: Text(tag.name),
                  selected: true,
                  visualDensity: VisualDensity.compact,
                  onSelected: (_) => cubit.toggleTag(tag),
                );
              }),
              if (state.selectedTags.isNotEmpty)
                ActionChip(
                  label: const Text('Wyczyść'),
                  avatar: Icon(
                    CustomIcons.delete_forever,
                    color: theme.colorScheme.onPrimary,
                  ),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    cubit.clearAll();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _FilteringChips extends StatelessWidget {
  const _FilteringChips();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FilteringCubit>(context);
    return SliverToBoxAdapter(
      child: BlocBuilder<FilteringCubit, FilteringState>(
        buildWhen: (p, c) =>
            p.tags != c.tags || p.selectedTags != c.selectedTags,
        builder: (context, state) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Wrap(
              key: ValueKey(state.tags.length),
              spacing: Dimensions.mediumPadding,
              runSpacing: 0,
              children: state.tags.map((tag) {
                if (state.isTagSelected(tag)) {
                  return const SizedBox.shrink();
                }
                return ChoiceChip(
                  label: Text(tag.name),
                  selected: state.isTagSelected(tag),
                  onSelected: (_) => cubit.toggleTag(tag),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
