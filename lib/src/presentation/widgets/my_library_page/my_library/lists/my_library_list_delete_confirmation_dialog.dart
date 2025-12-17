import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryListDeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onDelete;
  const MyLibraryListDeleteConfirmationDialog({
    super.key,
    required this.onDelete,
  });

  static void show({
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    showDialog(
      context: context,
      builder: (_) => MyLibraryListDeleteConfirmationDialog(onDelete: onDelete),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DialogWrapper(
      title: LocaleKeys.my_library_lists_delete_dialog_title.tr(),
      icon: CustomIcons.delete_forever,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Dimensions.veryLargePadding,
        children: [
          Text(
            LocaleKeys.my_library_lists_delete_dialog_content.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Dimensions.mediumPadding,
            children: [
              ElevatedButton(
                style: yellowElevatedButton,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  LocaleKeys.my_library_lists_delete_dialog_cancel.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
                child: Text(
                  LocaleKeys.my_library_lists_delete_dialog_delete.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
