import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  final String? uuid;
  const BookmarkPage({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tu będzie zakładka o id: $uuid'));
  }
}
