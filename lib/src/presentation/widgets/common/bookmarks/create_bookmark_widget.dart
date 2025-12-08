import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CreateBookmarkWidget extends StatefulWidget {
  final BookmarkModel? bookmark;
  final VoidCallback onDelete;
  final Function(String) onUpdate;
  final Function(String note)? onCreate;
  final VoidCallback onGoBack;
  final bool autofocus;
  final int lines;
  final double maxHeight;
  const CreateBookmarkWidget({
    required this.onDelete,
    required this.onUpdate,
    required this.onGoBack,
    this.autofocus = false,
    this.onCreate,
    this.bookmark,
    this.lines = 8,
    this.maxHeight = 250,
    super.key,
  });

  @override
  State<CreateBookmarkWidget> createState() => _CreateBookmarkWidgetState();
}

class _CreateBookmarkWidgetState extends State<CreateBookmarkWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bookmark != null) {
      _controller.text = widget.bookmark?.note ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.bookmark != null;
    final theme = Theme.of(context);
    final inputPadding = theme.inputDecorationTheme.contentPadding;
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: defaultCurve,
      child: SizedBox(
        height: widget.maxHeight,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.mediumPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Dimensions.mediumPadding,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    semanticLabel: isEditing
                        ? LocaleKeys.common_semantic_delete_or_go_back.tr()
                        : LocaleKeys.common_semantic_go_back_without_saving
                              .tr(),
                    icon: isEditing
                        ? CustomIcons.delete_forever
                        : Icons.arrow_back,
                    iconColor: isEditing
                        ? CustomColors.white
                        : CustomColors.black,
                    backgroundColor: isEditing
                        ? CustomColors.red
                        : CustomColors.white,
                    onPressed: () {
                      if (isEditing) {
                        widget.onDelete.call();
                        return;
                      }
                      widget.onGoBack.call();
                    },
                  ),
                  const Spacer(),
                  Flexible(
                    child: TextButtonWithIcon(
                      nonActiveText: isEditing
                          ? LocaleKeys.reading_sheet_bookmark_editing.tr()
                          : LocaleKeys.reading_sheet_bookmark_adding.tr(),
                      nonActiveIcon: Icons.bookmark_add_rounded,
                      activeColor: CustomColors.white,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Stack(
                  children: [
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        autofocus: widget.autofocus,
                        controller: _controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: (inputPadding?.horizontal ?? 0) / 2,
                            right:
                                Dimensions.elementHeight +
                                ((inputPadding?.horizontal ?? 0) / 2),
                            top: Dimensions.mediumPadding,
                            bottom: Dimensions.mediumPadding,
                          ),
                        ),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: CustomColors.black,
                        ),
                        maxLines: widget.lines,
                        minLines: widget.lines,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CustomButton(
                        semanticLabel: LocaleKeys.common_semantic_note.tr(),
                        icon: CustomIcons.stylus_note,
                        backgroundColor: CustomColors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CustomButton(
                        semanticLabel: isEditing
                            ? LocaleKeys.common_semantic_save_bookmark_changes
                                  .tr()
                            : LocaleKeys.common_semantic_create_bookmark.tr(),
                        icon: Icons.check,
                        backgroundColor: CustomColors.green,
                        onPressed: () {
                          if (isEditing) {
                            widget.onUpdate.call(_controller.text.trim());
                            return;
                          }

                          widget.onCreate?.call(_controller.text.trim());
                          _controller.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
