import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/detailed_author_model.dart';
import 'package:wolnelektury/src/presentation/cubits/author/author_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_details_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class AuthorPageTopBar extends StatelessWidget {
  const AuthorPageTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorCubit, AuthorState>(
      buildWhen: (p, c) {
        return p.isLoading != c.isLoading || p.author != c.author;
      },
      builder: (context, state) {
        if (!state.isLoading && state.author == null) {
          //todo error handling
          return const Text('Nie znaleziono autora');
        }
        return AnimatedBoxFade(
          isChildVisible: !state.isLoading,
          duration: const Duration(milliseconds: 300),
          child: state.isLoading
              ? const CustomLoader()
              : _Body(author: state.author!),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DetailedAuthorModel author;
  const _Body({required this.author});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: Dimensions.mediumPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox.square(
                dimension: constraints.maxWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.darkModeGrey.withValues(alpha: 0.15),
                  ),
                  child: author.photo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusOfCircle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: author.photo!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 55,
                          color: CustomColors.darkModeGrey,
                        ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimensions.mediumPadding),
              if ((author.description ?? '').isNotEmpty)
                Stack(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Html(
                        data: author.description,
                        style: {
                          'body': Style(
                            fontSize: FontSize(14),
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0, 1],
                            colors: [
                              theme.scaffoldBackgroundColor.withValues(
                                alpha: 0,
                              ),
                              theme.scaffoldBackgroundColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (author.description != null && author.description!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWellWrapper(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        AuthorPageDetailsDialog.show(
                          context,
                          author.name,
                          author.description!,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.mediumPadding,
                        ),
                        child: Text(
                          LocaleKeys.catalogue_author_more.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: CustomColors.secondaryBlueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
