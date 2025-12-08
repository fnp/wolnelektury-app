import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class SocialsBottomSheet extends StatelessWidget {
  const SocialsBottomSheet({super.key});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      return;
    }
  }

  static void show({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (_) => const SocialsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
    final theme = Theme.of(context);
    return SafeArea(
      bottom: true,
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                leading: Image.asset(Images.facebook, width: 24, height: 24),
                title: Text(
                  LocaleKeys.settings_social_fb.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  _launchInBrowser(
                    Uri.parse('https://www.facebook.com/wolnelektury'),
                  );
                },
              ),
              ListTile(
                shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                leading: Image.asset(Images.instagram, width: 24, height: 24),
                title: Text(
                  LocaleKeys.settings_social_ig.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  _launchInBrowser(
                    Uri.parse('https://www.instagram.com/wolnelektury/'),
                  );
                },
              ),
              ListTile(
                shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                leading: Image.asset(Images.youtube, width: 24, height: 24),
                title: Text(
                  LocaleKeys.settings_social_yt.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  _launchInBrowser(
                    Uri.parse('https://www.youtube.com/@WolneLekturyYT'),
                  );
                },
              ),
              const SizedBox(height: Dimensions.spacer),
            ],
          ),
        ),
      ),
    );
  }
}
