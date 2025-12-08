import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class SearchBar extends StatefulWidget {
  final VoidCallback onClear;
  final Function(String) onChanged;
  final String? initialValue;
  const SearchBar({
    super.key,
    required this.onChanged,
    required this.onClear,
    this.initialValue,
  });

  @override
  State<SearchBar> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final TextEditingController controller = TextEditingController();
  late ThemeData theme;
  bool isEmpty = true;

  @override
  void initState() {
    isEmpty = widget.initialValue == null || widget.initialValue!.isEmpty;
    controller.text = widget.initialValue ?? '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: Dimensions.elementHeight),
      child: Row(
        spacing: Dimensions.mediumPadding,
        children: [
          CustomButton(
            semanticLabel: LocaleKeys.common_semantic_back_to_previous_page
                .tr(),
            icon: Icons.arrow_back,
            iconColor: theme.colorScheme.onSurface,
            backgroundColor: theme.colorScheme.tertiaryContainer,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              controller: controller,
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {
                  isEmpty = value.trim().isEmpty;
                });
              },
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              cursorColor: CustomColors.black,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: Dimensions.mediumPadding,
                  horizontal: Dimensions.veryLargePadding,
                ),
                suffixIconColor: CustomColors.black,
                // isDense: true,
                fillColor: CustomColors.primaryYellowColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.borderRadiusOfCircle,
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.borderRadiusOfCircle,
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.borderRadiusOfCircle,
                  ),
                  borderSide: BorderSide.none,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 40,
                  minWidth: 40,
                ),
                suffixIcon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  switchInCurve: defaultCurve,
                  switchOutCurve: defaultCurve,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: isEmpty
                      ? const SizedBox.square(
                          dimension: 40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.search, size: 24),
                          ),
                        )
                      : CustomButton(
                          semanticLabel: LocaleKeys.common_semantic_clear_search
                              .tr(),
                          key: const ValueKey('clear_search'),
                          icon: Icons.close,
                          onPressed: () {
                            controller.clear();
                            widget.onClear();
                            setState(() {
                              isEmpty = true;
                            });
                          },
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
