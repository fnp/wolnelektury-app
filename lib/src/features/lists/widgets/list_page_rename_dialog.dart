import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_size.dart';
import 'package:wolnelektury/src/features/common/widgets/dialog_wrapper.dart';
import 'package:wolnelektury/src/features/common/widgets/textfield/text_field_validation_error.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ListPageRenameDialog extends StatefulWidget {
  final String listSlug;
  final String currentName;

  const ListPageRenameDialog({
    super.key,
    required this.listSlug,
    required this.currentName,
  });

  static void show({
    required BuildContext context,
    required String listSlug,
    required String currentName,
  }) {
    showDialog(
      context: context,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ListCreatorCubit>()),
        ],
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Builder(
            builder: (context) {
              return BlocListener<ListCreatorCubit, ListCreatorState>(
                listenWhen: (p, c) {
                  return p.isRenaming && !c.isRenaming;
                },
                listener: (context, state) {
                  if (!state.isRenaming &&
                      !state.isRenamingFailure &&
                      !state.isDuplicateFailure) {
                    Navigator.of(context).pop();
                    CustomSnackbar.success(
                      context,
                      LocaleKeys.my_library_lists_rename_dialog_success.tr(),
                    );
                  }
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    ListPageRenameDialog(
                      listSlug: listSlug,
                      currentName: currentName,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  State<ListPageRenameDialog> createState() => _ListPageRenameDialogState();
}

class _ListPageRenameDialogState extends State<ListPageRenameDialog> {
  late ThemeData theme;
  late TextEditingController _listNameController;
  bool showListNameError = false;

  @override
  void initState() {
    super.initState();
    _listNameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _listNameController.dispose();
    super.dispose();
  }

  void validate() {
    setState(() {
      showListNameError = _listNameController.text.trim().isEmpty;
    });
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      title: LocaleKeys.my_library_lists_rename_dialog_title.tr().toUpperCase(),
      icon: Icons.edit_note_outlined,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List name field
            TextField(
              controller: _listNameController,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CustomColors.black,
              ),
              decoration: InputDecoration(
                hintText: LocaleKeys.my_library_lists_rename_dialog_name_hint
                    .tr(),
                fillColor: theme.colorScheme.primaryFixed,
              ),
              onChanged: (value) {
                if (showListNameError) validate();
              },
              minLines: 1,
              maxLines: 5,
            ),
            AnimatedBoxSize(
              isChildVisible: showListNameError,
              duration: const Duration(milliseconds: 200),
              child: TextFieldValidationError(
                message: LocaleKeys
                    .my_library_lists_rename_dialog_name_validation
                    .tr(),
              ),
            ),

            const SizedBox(height: Dimensions.spacer),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: Dimensions.mediumPadding,
              children: [
                Expanded(
                  child: BlocConsumer<ListCreatorCubit, ListCreatorState>(
                    listenWhen: (p, c) {
                      return p.isRenamingFailure != c.isRenamingFailure ||
                          p.isDuplicateFailure != c.isDuplicateFailure;
                    },
                    listener: (context, state) {
                      if (state.isRenamingFailure) {
                        CustomSnackbar.error(
                          context,
                          LocaleKeys.my_library_lists_rename_dialog_error.tr(),
                        );
                        return;
                      }
                      if (state.isDuplicateFailure) {
                        CustomSnackbar.error(
                          context,
                          LocaleKeys
                              .my_library_lists_rename_dialog_duplicate_error
                              .tr(),
                        );
                        return;
                      }
                    },
                    buildWhen: (p, c) => p.isRenaming != c.isRenaming,
                    builder: (context, state) {
                      return ElevatedButton(
                        style: yellowElevatedButton,
                        onPressed: () {
                          if (state.isRenaming) return;
                          validate();
                          if (!showListNameError) {
                            context.read<ListCreatorCubit>().renameList(
                              listSlug: widget.listSlug,
                              newName: _listNameController.text.trim(),
                            );
                          }
                        },
                        child: AnimatedBoxFade(
                          isChildVisible: !state.isRenaming,
                          duration: const Duration(milliseconds: 300),
                          collapsedChild: const CustomLoader(
                            size: 15,
                            strokeWidth: 2,
                            color: CustomColors.black,
                          ),
                          child: Text(
                            LocaleKeys.my_library_lists_rename_dialog_save.tr(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: CustomColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
