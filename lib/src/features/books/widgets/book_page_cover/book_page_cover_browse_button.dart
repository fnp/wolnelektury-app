import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/features/catalogue/widgets/dialog/catalogue_page_select_child_dialog.dart';
import 'package:wolnelektury/src/features/common/widgets/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';

class BookPageCoverBrowseButton extends StatelessWidget {
  final BookModel book;
  const BookPageCoverBrowseButton({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return TextButtonWithIcon(
      nonActiveText: LocaleKeys.common_icon_button_browse.tr(),
      nonActiveIcon: CustomIcons.book_5,
      isActive: false,
      onPressed: () {
        CataloguePageSelectChildDialog.show(context: context, book: book);
      },
    );
  }
}
