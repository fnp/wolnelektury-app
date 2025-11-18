import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReaderBottomSheet extends StatelessWidget {
  final ReaderBookModelContent element;
  final ReaderBookModelContent linkContent;
  final String fontFamily;
  final double fontSize;
  final bool debugPrint;
  final bool isTheme;

  const ReaderBottomSheet({
    super.key,
    required this.element,
    required this.linkContent,
    required this.fontFamily,
    required this.fontSize,
    required this.debugPrint,
    this.isTheme = false,
  });

  static void show({
    required ReaderBookModelContent element,
    required ReaderBookModelContent linkContent,
    required String fontFamily,
    required double fontSize,
  }) {
    showModalBottomSheet(
      context: dashboardNavigationKey.currentContext!,
      useRootNavigator: true,
      builder: (context) {
        return ReaderBottomSheet(
          element: element,
          linkContent: linkContent,
          fontFamily: fontFamily,
          fontSize: fontSize,
          debugPrint: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 150,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.spacer),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: buildReaderBase(
                    theme: Theme.of(context),
                    element: linkContent,
                    parent: element,
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            if (isTheme)
              const Icon(Icons.theater_comedy, color: CustomColors.white),
          ],
        ),
      ),
    );
  }
}
