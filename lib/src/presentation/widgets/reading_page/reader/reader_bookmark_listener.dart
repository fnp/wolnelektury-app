import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/success_enum.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

class BookmarkListener extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  const BookmarkListener({
    super.key,
    required this.child,
    this.scaffoldMessengerKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookmarksCubit, BookmarksState>(
      listenWhen: (p, c) => p.isBookmarkSuccess != c.isBookmarkSuccess,
      listener: (context, state) {
        if (state.isBookmarkSuccess == null) return;
        determineSnackbar(
          context: context,
          state: state.isBookmarkSuccess!,
          scaffoldMessengerKey: scaffoldMessengerKey,
        );
      },
      child: child,
    );
  }

  void determineSnackbar({
    required BuildContext context,
    required SuccessState state,
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
  }) {
    switch (state.$1) {
      case Success.update:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_edited_success.tr(),
            messengerKey: scaffoldMessengerKey,
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_edit_error.tr(),
            messengerKey: scaffoldMessengerKey,
          );
        }
        break;
      case Success.delete:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_deleted_success.tr(),
            messengerKey: scaffoldMessengerKey,
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_delete_error.tr(),
            messengerKey: scaffoldMessengerKey,
          );
        }
        break;
      case Success.create:
        if (state.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reading_snackbar_bookmark_added_success.tr(),
            messengerKey: scaffoldMessengerKey,
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reading_snackbar_bookmark_add_error.tr(),
            messengerKey: scaffoldMessengerKey,
          );
        }
        break;
    }
  }
}
