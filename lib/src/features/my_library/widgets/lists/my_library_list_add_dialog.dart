import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class MyLibraryListAddDialog extends StatelessWidget {
  final ListModel list;
  final VoidCallback onAddBooks;
  final VoidCallback onAddBookmarks;
  const MyLibraryListAddDialog({
    super.key,
    required this.list,
    required this.onAddBooks,
    required this.onAddBookmarks,
  });

  static void show({
    required BuildContext context,
    required ListModel list,
    required VoidCallback onAddBooks,
    required VoidCallback onAddBookmarks,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return MyLibraryListAddDialog(
          list: list,
          onAddBooks: onAddBooks,
          onAddBookmarks: onAddBookmarks,
        );
      },
    );
  }

  void _onAddBooks(BuildContext context) {
    Navigator.of(context).pop();
    onAddBooks();
  }

  void _onAddBookmarks(BuildContext context) {
    Navigator.of(context).pop();
    onAddBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      icon: Icons.edit_note_outlined,
      title: LocaleKeys.my_library_lists_add_dialog_title.tr(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AddOption(
            icon: CustomIcons.book_5,
            title: LocaleKeys.my_library_lists_add_dialog_books.tr(),
            onTap: () => _onAddBooks(context),
          ),
          const SizedBox(height: Dimensions.smallPadding),
          _AddOption(
            icon: CustomIcons.bookmark,
            title: LocaleKeys.my_library_lists_add_dialog_bookmarks.tr(),
            onTap: () => _onAddBookmarks(context),
          ),
        ],
      ),
    );
  }
}

class _AddOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AddOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Dimensions.elementHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixed,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        child: InkWellWrapper(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.mediumPadding,
            ),
            child: Row(
              children: [
                Icon(icon, color: theme.colorScheme.onPrimaryFixed, size: 24),
                const SizedBox(width: Dimensions.mediumPadding),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryFixed,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
