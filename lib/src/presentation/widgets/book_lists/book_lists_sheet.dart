import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_lists/book_lists_sheet_existing_lists.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookListsSheet extends StatelessWidget {
  final String bookSlug;
  const BookListsSheet({super.key, required this.bookSlug});

  static void show({
    required BuildContext context,
    required String bookSlug,
    required VoidCallback onSave,
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
      isScrollControlled: true,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ListCreatorCubit>()),
          BlocProvider.value(value: context.read<ScrollCubit>()),
        ],
        child: BookListsSheet(bookSlug: bookSlug),
      ),
    ).then((_) {
      onSave.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableHeight = MediaQuery.sizeOf(context).height / 2;
    final cubit = BlocProvider.of<ListCreatorCubit>(context);
    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: BlocBuilder<ListCreatorCubit, ListCreatorState>(
        buildWhen: (p, c) {
          return p.allLists != c.allLists;
        },
        builder: (context, state) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: availableHeight,
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
                        icon: CustomIcons.close,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.spacer),
                  Flexible(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                      child: BookListsSheetExistingLists(
                        currentlyWorkingOnBookSlug: bookSlug,
                        effectiveList: state.allLists,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.mediumPadding),
                  AddNewListElement(
                    onSave: (String text) {
                      cubit.newList(text, bookSlugs: [bookSlug]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddNewListElement extends StatefulWidget {
  final Function(String text) onSave;
  const AddNewListElement({super.key, required this.onSave});

  @override
  State<AddNewListElement> createState() => AddNewListElementState();
}

class AddNewListElementState extends State<AddNewListElement> {
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
      child: SizedBox(
        width: double.infinity,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: Dimensions.elementHeight,
          ),
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
                  data: theme.copyWith(inputDecorationTheme: alternativeInput),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
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

              AnimatedBoxFade(
                isChildVisible: isReadyToSave,
                child: ElevatedButton(
                  style: blueElevatedButton,
                  onPressed: () {
                    widget.onSave.call(_controller.text);
                    _controller.clear();
                    setState(() {
                      isReadyToSave = false;
                    });
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(LocaleKeys.book_lists_sheet_save.tr()),
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
