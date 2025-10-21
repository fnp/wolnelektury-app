import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        LocaleKeys.common_empty_page.tr(),
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}
