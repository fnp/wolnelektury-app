import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Tutaj będą ostatnio czytane ⏱️',
        style: theme.textTheme.headlineSmall,
      ),
    );
  }
}
