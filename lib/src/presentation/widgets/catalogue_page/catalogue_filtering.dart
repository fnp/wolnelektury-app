import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CatalogueFiltering extends StatelessWidget {
  const CatalogueFiltering({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteringCubit, FilteringState>(
      buildWhen: (p, c) => p.isAnyTagSelected != c.isAnyTagSelected,
      builder: (context, state) {
        return TextButtonWithIcon(
          nonActiveText: LocaleKeys.common_icon_button_filter.tr(),
          nonActiveIcon: Icons.filter_alt,
          activeColor: CustomColors.primaryYellowColor,
          activeIcon: Icons.filter_alt,
          isActive: state.isAnyTagSelected,
          onPressed: () {
            final globalContext = routerNavigationKey.currentContext;
            if (globalContext == null) {
              return;
            }
            Navigator.push(
              globalContext,
              MaterialPageRoute(
                builder: (_) {
                  context.read<FilteringCubit>();
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<FilteringCubit>()),
                      BlocProvider.value(value: context.read<ScrollCubit>()),
                    ],
                    child: const _FiltersWidget(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _FiltersWidget extends StatelessWidget {
  const _FiltersWidget();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: CustomColors.primaryYellowColor,
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
                    BlocProvider.of<FilteringCubit>(context).loadMore();
                  },
                  builder: (controller) {
                    return CustomScrollView(
                      controller: controller,
                      slivers: [
                        _SearchWithX(initialText: state.query),
                        const SliverToBoxAdapter(child: SizedBox(height: 4)),
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
      ),
    );
  }
}

class _SearchWithX extends StatefulWidget {
  final String? initialText;
  const _SearchWithX({required this.initialText});

  @override
  State<_SearchWithX> createState() => _SearchWithXState();
}

class _SearchWithXState extends State<_SearchWithX> {
  final TextEditingController controller = TextEditingController();
  late ThemeData theme;
  bool isEmpty = true;

  @override
  void initState() {
    isEmpty = widget.initialText == null || widget.initialText!.isEmpty;
    controller.text = widget.initialText ?? '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<FilteringCubit>(context);
    return SliverToBoxAdapter(
      child: Row(
        spacing: Dimensions.mediumPadding,
        children: [
          Expanded(
            child: SizedBox(
              height: Dimensions.elementHeight,
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: controller,
                onChanged: (value) {
                  cubit.changeQuery(value);
                  setState(() {
                    isEmpty = value.trim().isEmpty;
                  });
                },
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: Dimensions.smallPadding,
                    horizontal: Dimensions.veryLargePadding,
                  ),
                  suffixIconColor: CustomColors.black,
                  isDense: true,
                  fillColor: CustomColors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    switchInCurve: Curves.fastOutSlowIn,
                    switchOutCurve: Curves.fastOutSlowIn,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: isEmpty
                        ? const SizedBox.square(
                            dimension: 40,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.search, size: 24),
                            ),
                          )
                        : CustomButton(
                            backgroundColor: CustomColors.grey,
                            key: const ValueKey('clear_search'),
                            icon: Icons.close,
                            onPressed: () {
                              controller.clear();
                              cubit.changeQuery('');
                              setState(() {
                                isEmpty = true;
                              });
                            },
                          ),
                  ),
                ),
              ),
            ),
          ),
          CustomButton(
            icon: CustomIcons.close,
            iconColor: theme.colorScheme.onSurface,
            backgroundColor: theme.colorScheme.tertiaryContainer,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _SelectedTags extends StatelessWidget {
  const _SelectedTags();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilteringCubit>();

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
            children: state.selectedTags
                .map(
                  (tag) => ChoiceChip(
                    label: Text(tag.name),
                    selected: true,
                    visualDensity: VisualDensity.compact,
                    onSelected: (_) => cubit.toggleTag(tag),
                  ),
                )
                .toList(),
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
