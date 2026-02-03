import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookListsCreateWidget extends StatefulWidget {
  final Function(String text) onSave;
  const BookListsCreateWidget({super.key, required this.onSave});

  @override
  State<BookListsCreateWidget> createState() => BookListsCreateWidgetState();
}

class BookListsCreateWidgetState extends State<BookListsCreateWidget> {
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CustomColors.black,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Dimensions.elementHeight),
        child: Row(
          children: [
            const SizedBox(width: Dimensions.mediumPadding),
            const Icon(
              CustomIcons.playlist_add,
              color: CustomColors.white,
              size: 22,
            ),
            const SizedBox(width: Dimensions.smallPadding),
            Expanded(
              child: Theme(
                data: theme.copyWith(
                  inputDecorationTheme: alternativeInput,
                  textSelectionTheme: theme.textSelectionTheme.copyWith(
                    cursorColor: CustomColors.white,
                    selectionHandleColor: CustomColors.white,
                  ),
                ),
                child: TextField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    suffixIcon: isReadyToSave
                        ? _SaveButton(
                            onPressed: () {
                              widget.onSave.call(_controller.text);
                              _controller.clear();
                              setState(() {
                                isReadyToSave = false;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    hintText: LocaleKeys.book_lists_sheet_add.tr(),
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.white,
                    ),
                    border: InputBorder.none,
                  ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) {
        return p.isAdding != c.isAdding;
      },
      builder: (context, state) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          opacity: state.isAdding ? 0.5 : 1.0,
          child: ElevatedButton(
            style: greenElevatedButton,
            onPressed: state.isAdding ? null : onPressed,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Text(LocaleKeys.book_lists_sheet_save.tr()),
            ),
          ),
        );
      },
    );
  }
}
