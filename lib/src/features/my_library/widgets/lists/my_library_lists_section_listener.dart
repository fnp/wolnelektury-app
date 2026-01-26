import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

class MyLibraryListsSectionListener extends StatelessWidget {
  final Widget child;
  const MyLibraryListsSectionListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final listCubit = context.read<ListCreatorCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<ListCreatorCubit, ListCreatorState>(
          listenWhen: (p, c) {
            return p.isDuplicateFailure != c.isDuplicateFailure;
          },
          listener: (context, state) {
            if (state.isDuplicateFailure) {
              CustomSnackbar.error(
                context,
                LocaleKeys.my_library_lists_rename_dialog_duplicate_error.tr(),
                messengerKey: CustomSnackbar.scaffoldMessengerKey,
              );
            }
          },
        ),
        BlocListener<ListCreatorCubit, ListCreatorState>(
          listenWhen: (p, c) {
            return p.isAddingFailure != c.isAddingFailure ||
                p.isDeleteFailure != c.isDeleteFailure ||
                p.isRemovingBookFailure != c.isRemovingBookFailure ||
                (p.deletingSlug != null &&
                    c.deletingSlug == null &&
                    !c.isDeleteFailure);
          },
          listener: (context, state) {
            if (state.isAddingFailure) {
              CustomSnackbar.error(
                context,
                LocaleKeys.my_library_lists_creation_failure.tr(),
              );
              return;
            }
            if (state.isDeleteFailure) {
              CustomSnackbar.error(
                context,
                LocaleKeys.my_library_lists_deletion_failure.tr(),
              );
              return;
            }
            if (state.isRemovingBookFailure) {
              CustomSnackbar.error(
                context,
                LocaleKeys.my_library_lists_book_removal_failure.tr(),
              );
              return;
            }
            // Refresh lists after successful deletion
            if (state.deletingSlug == null) {
              listCubit.getLists(force: true);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
