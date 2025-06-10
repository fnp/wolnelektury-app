import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AuthorPageDetailsDialog extends StatelessWidget {
  final String authorName;
  final String authorDescription;
  const AuthorPageDetailsDialog({
    super.key,
    required this.authorName,
    required this.authorDescription,
  });

  static void show(
    BuildContext context,
    String authorName,
    String authorDescription,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AuthorPageDetailsDialog(
          authorName: authorName,
          authorDescription: authorDescription,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.spacer),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.66,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      authorName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomButton(
                      icon: Icons.close,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Html(data: authorDescription),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
