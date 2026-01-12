import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/features/catalogue/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class BookPageDetailsTable extends StatelessWidget {
  final BookModel book;
  const BookPageDetailsTable({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimensions.mediumPadding,
      children: [
        if (book.epochs.isNotEmpty) ...[
          _BookPageDetailsTableRow(
            title: LocaleKeys.book_epoch.tr(),
            pills: [
              ...book.epochs.map(
                (e) => _Pill(
                  onTap: () {
                    if (e.id == null) return;
                    final filterCubit = context.read<FilteringCubit>();
                    filterCubit.toggleTag(
                      TagModel.fromId(e.id!, name: e.name!),
                      resetRest: true,
                    );
                    router.pushNamed(cataloguePageConfig.name);
                  },
                  label: e.name!,
                ),
              ),
            ],
          ),
        ],
        if (book.kinds.isNotEmpty) ...[
          _BookPageDetailsTableRow(
            title: LocaleKeys.book_kind.tr(),
            pills: [
              ...book.kinds.map(
                (k) => _Pill(
                  onTap: () {
                    if (k.id == null) return;
                    final filterCubit = context.read<FilteringCubit>();
                    filterCubit.toggleTag(
                      TagModel.fromId(k.id!, name: k.name!),
                      resetRest: true,
                    );
                    router.pushNamed(cataloguePageConfig.name);
                  },
                  label: k.name!,
                ),
              ),
            ],
          ),
        ],
        if (book.genres.isNotEmpty) ...[
          _BookPageDetailsTableRow(
            title: LocaleKeys.book_genre.tr(),
            pills: [
              ...book.genres.map(
                (g) => _Pill(
                  onTap: () {
                    if (g.id == null) return;
                    final filterCubit = context.read<FilteringCubit>();
                    filterCubit.toggleTag(
                      TagModel.fromId(g.id!, name: g.name!),
                      resetRest: true,
                    );
                    router.pushNamed(cataloguePageConfig.name);
                  },
                  label: g.name!,
                ),
              ),
            ],
          ),
          if (book.elevenReaderLink != null)
            _BookPageDetailsTableRow(
              title: LocaleKeys.book_available_in.tr(),
              pills: [
                _Pill(
                  backgroundColor: CustomColors.secondaryBlueColor,
                  textColor: CustomColors.white,
                  onTap: () {
                    launchUrlString(book.elevenReaderLink!);
                  },
                  label: 'ElevenReader',
                ),
              ],
            ),
        ],
      ],
    );
  }
}

class _BookPageDetailsTableRow extends StatelessWidget {
  final String title;
  final List<Widget> pills;

  const _BookPageDetailsTableRow({required this.title, required this.pills});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: Dimensions.mediumPadding),
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: pills,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  const _Pill({
    required this.onTap,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
      ),
      child: InkWellWrapper(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
            vertical: Dimensions.smallPadding,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
