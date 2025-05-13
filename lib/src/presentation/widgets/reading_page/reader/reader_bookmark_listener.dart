import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/success_enum.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

class ReaderBookmarkListener extends StatelessWidget {
  final Widget child;
  const ReaderBookmarkListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadingPageCubit, ReadingPageState>(
      listenWhen: (p, c) => p.isBookmarkSuccess != c.isBookmarkSuccess,
      listener: (context, state) {
        if (state.isBookmarkSuccess == null) return;
        determineSnackbar(
          context: context,
          state: state.isBookmarkSuccess!,
        );
      },
      child: child,
    );
  }

  void determineSnackbar({
    required BuildContext context,
    required SuccessState state,
  }) {
    switch (state.$1) {
      case Success.update:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_edited_success.tr(),
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_edit_error.tr(),
          );
        }
        break;
      case Success.delete:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_deleted_success.tr(),
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_delete_error.tr(),
          );
        }
        break;
      case Success.create:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_added_success.tr(),
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_add_error.tr(),
          );
        }
        break;
    }
  }
}
