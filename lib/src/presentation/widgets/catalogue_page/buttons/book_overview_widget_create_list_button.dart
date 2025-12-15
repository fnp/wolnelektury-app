import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_lists/book_lists_sheet.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/buttons/book_overview_widget_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

class BookOverviewWidgetCreateListButton extends StatelessWidget {
  final BookModel book;
  final double? size;
  final double? iconSize;
  const BookOverviewWidgetCreateListButton({
    super.key,
    required this.book,
    this.size,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      child: (isAuthenticated) {
        return BookOverviewWidgetButton(
          size: size,
          iconSize: iconSize,
          onTap: () {
            if (!isAuthenticated) {
              CustomSnackbar.loginRequired(context);
              return;
            }
            final cubit = BlocProvider.of<ListCreatorCubit>(context);

            cubit.getLists(force: true);
            BookListsSheet.show(
              context: context,
              bookSlug: book.slug,
              onSave: () {
                cubit.save();
              },
            );
          },
          nonActiveBackgroundColor: CustomColors.white,
          activeBackgroundColor: CustomColors.primaryYellowColor,
          nonActiveIcon: CustomIcons.playlist_add,
        );
      },
    );
  }
}
