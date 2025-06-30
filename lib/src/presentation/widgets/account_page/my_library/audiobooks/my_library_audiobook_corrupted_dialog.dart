import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryAudiobookCorruptedDialog extends StatelessWidget {
  final VoidCallback onDownloadAgain;
  final VoidCallback onDelete;
  const MyLibraryAudiobookCorruptedDialog({
    super.key,
    required this.onDownloadAgain,
    required this.onDelete,
  });

  static void show({
    required BuildContext context,
    required VoidCallback onDownloadAgain,
    required VoidCallback onDelete,
  }) {
    showDialog(
      context: context,
      builder: (_) => MyLibraryAudiobookCorruptedDialog(
        onDownloadAgain: onDownloadAgain,
        onDelete: onDelete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DialogWrapper(
      title: 'Pliki audiobooka są uszkodzone',
      icon: CustomIcons.delete_forever,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Dimensions.veryLargePadding,
        children: [
          Text(
            'Pliki audiobooka są uszkodzone lub niekompletne.',
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
                  onDownloadAgain();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Pobierz',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
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
                  'Usuń',
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
