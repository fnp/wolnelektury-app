import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/features/common/widgets/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryAudiobookNoWifiDialog extends StatelessWidget {
  final VoidCallback onDownloadAnyway;
  const MyLibraryAudiobookNoWifiDialog({
    super.key,
    required this.onDownloadAnyway,
  });

  static void show({
    required BuildContext context,
    required VoidCallback onDownloadAnyway,
  }) {
    showDialog(
      context: context,
      builder: (_) =>
          MyLibraryAudiobookNoWifiDialog(onDownloadAnyway: onDownloadAnyway),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DialogWrapper(
      title: LocaleKeys.my_library_wifi_dialog_title.tr(),
      icon: Icons.wifi_off,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.my_library_wifi_dialog_content.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
          const SizedBox(height: Dimensions.spacer),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: yellowElevatedButton,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onDownloadAnyway();
                  },
                  child: Text(
                    LocaleKeys.my_library_wifi_dialog_button.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
