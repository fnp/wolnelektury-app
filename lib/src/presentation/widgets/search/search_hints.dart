import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/hint_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/search/search_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/hint_type_enum.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class SearchHints extends StatelessWidget {
  const SearchHints({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (p, c) {
        return p.hints != c.hints;
      },
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: Column(
            children: [
              BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (p, c) =>
                    p.isLoadingHints != c.isLoadingHints || p.hints != c.hints,
                builder: (context, state) {
                  if (state.isLoadingHints && state.hints.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(Dimensions.mediumPadding),
                      child: CustomLoader(
                        strokeWidth: 2,
                        size: Dimensions.elementHeight / 2,
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.hints.length,
                itemBuilder: (context, index) {
                  final hint = state.hints[index];
                  return _HintElement(hint: hint, key: ValueKey(hint.hashCode));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HintElement extends StatelessWidget {
  final HintModel hint;
  const _HintElement({super.key, required this.hint});

  void handleTap(BuildContext context) {
    switch (hint.type) {
      case HintTypeEnum.author:
        if (hint.slug == null) return;
        router.pushNamed(
          authorPageConfig.name,
          pathParameters: {'slug': hint.slug!},
        );
        break;
      case HintTypeEnum.book:
        if (hint.slug == null) return;
        router.pushNamed(
          bookPageConfig.name,
          pathParameters: {'slug': hint.slug!},
        );
        break;
      case HintTypeEnum.epoch:
      case HintTypeEnum.genre:
      case HintTypeEnum.kind:
        if (hint.id == null) return;
        final filterCubit = context.read<FilteringCubit>();
        filterCubit.toggleTag(TagModel.fromId(hint.id!, name: hint.label));
        router.pushNamed(cataloguePageConfig.name);
        break;
      case HintTypeEnum.theme:
        // Handle kind hint tap
        break;
      case HintTypeEnum.collection:
        // Handle kind hint tap
        break;
      case HintTypeEnum.info:
        // Handle kind hint tap
        break;
      case HintTypeEnum.userlist:
        // Handle kind hint tap
        break;
      case HintTypeEnum.unknown:
        // Handle kind hint tap
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Dimensions.elementHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        child: InkWellWrapper(
          onTap: () => handleTap(context),
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          child: Row(
            children: [
              const SizedBox(width: Dimensions.veryLargePadding),
              Expanded(
                child: Text(
                  hint.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if ((hint.img ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.mediumPadding,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: hint.img!,
                      fit: BoxFit.cover,
                      width: Dimensions.elementHeight,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
