import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryListBookmark extends StatelessWidget {
  final String bookmarkId;
  final String listSlug;
  final String listName;
  final bool isListOwner;

  const MyLibraryListBookmark({
    super.key,
    required this.bookmarkId,
    required this.listSlug,
    required this.listName,
    this.isListOwner = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.spacer),
      child: Text('Bookmark: $bookmarkId'),
    );
  }
}
