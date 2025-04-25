import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookListsSheet extends StatelessWidget {
  const BookListsSheet({super.key});

  static void show({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      enableDrag: false,
      backgroundColor: CustomColors.primaryYellowColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      context: context,
      useRootNavigator: true,
      builder: (_) => const BookListsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //todo downloading existing lists
    final theme = Theme.of(context);
    final availableHeight = MediaQuery.sizeOf(context).height / 2;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: availableHeight,
        minHeight: availableHeight / 2,
        minWidth: double.infinity,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.modalsPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.book_lists_sheet_title.tr().toUpperCase(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 1.14,
                    ),
                  ),
                ),
                CustomButton(
                  backgroundColor: CustomColors.white,
                  icon: Icons.close,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.spacer),
            const _AddNewElement(),
          ],
        ),
      ),
    );
  }
}

class _AddNewElement extends StatefulWidget {
  const _AddNewElement();

  @override
  State<_AddNewElement> createState() => _AddNewElementState();
}

class _AddNewElementState extends State<_AddNewElement> {
  bool isAdding = false;
  bool isReadyToSave = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          isAdding = true;
        });
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CustomColors.black,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        child: SizedBox(
          width: double.infinity,
          height: Dimensions.elementHeight,
          child: Row(
            children: [
              const SizedBox(
                width: Dimensions.mediumPadding,
              ),
              const Icon(
                Icons.playlist_add,
                color: CustomColors.white,
                size: 22,
              ),
              const SizedBox(width: Dimensions.smallPadding),
              isAdding
                  ? Flexible(
                      child: Theme(
                        data: theme.copyWith(
                          inputDecorationTheme: alternativeInput,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              isReadyToSave = value.isNotEmpty;
                            });
                          },
                          controller: _controller,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.white,
                            decorationColor: CustomColors.red,
                          ),
                          autofocus: true,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.mediumPadding,
                      ),
                      child: Text(
                        LocaleKeys.book_lists_sheet_add.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.white,
                        ),
                      ),
                    ),
              AnimatedBoxFade(
                isChildVisible: isReadyToSave,
                child: ElevatedButton(
                  style: blueElevatedButton,
                  onPressed: () {
                    //todo adding new lists
                  },
                  child: Text(
                    LocaleKeys.book_lists_sheet_save.tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
