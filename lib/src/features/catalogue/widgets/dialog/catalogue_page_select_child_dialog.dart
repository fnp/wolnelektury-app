import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/features/common/widgets/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class CataloguePageSelectChildDialog extends StatelessWidget {
  final BookModel book;
  const CataloguePageSelectChildDialog({super.key, required this.book});

  static void show({required BuildContext context, required BookModel book}) {
    showDialog(
      context: context,
      builder: (_) {
        return CataloguePageSelectChildDialog(book: book);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      icon: CustomIcons.book_5,
      title: LocaleKeys.catalogue_child_selection_dialog_title.tr(),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: book.children.map((child) {
                  return _Child(child: child, imageUrl: book.coverUrl ?? '');
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  final BookChild child;
  final String imageUrl;
  const _Child({required this.child, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.smallPadding),
      child: SizedBox(
        height: Dimensions.elementHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryFixed,
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadiusOfCircle,
            ),
          ),
          child: InkWellWrapper(
            onTap: () {
              Navigator.of(context).pop();
              router.pushNamed(
                bookPageConfig.name,
                pathParameters: {'slug': child.slug},
              );
            },
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadiusOfCircle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: Dimensions.mediumPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      child.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryFixed,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: Dimensions.elementHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
