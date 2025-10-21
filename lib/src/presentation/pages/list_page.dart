import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/presentation/widgets/common/empty_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/lists/my_library_list.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class ListPage extends StatelessWidget {
  final String? slug;
  final BookListModel? bookList;
  const ListPage({super.key, required this.slug, required this.bookList});

  @override
  Widget build(BuildContext context) {
    //todo Mozna zrobic pobieranie po slugu
    if (bookList == null) {
      return const SizedBox.shrink();
    }
    if (bookList!.books.isEmpty) {
      return EmptyWidget(
        image: Images.empty,
        message: 'Nie dodano jeszcze żadnych książek',
        onTap: () {
          router.pushNamed(cataloguePageConfig.name);
        },
        buttonText: 'Przeglądaj katalog',
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.mediumPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: Dimensions.largePadding),
            MyLibraryList(bookList: bookList!, includeBooks: true),
            const SizedBox(height: Dimensions.largePadding),
          ],
        ),
      ),
    );
  }
}
