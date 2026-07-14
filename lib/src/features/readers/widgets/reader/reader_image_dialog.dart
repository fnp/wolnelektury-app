import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/router/router.dart';

class ReaderImageDialog extends StatelessWidget {
  final String imageUrl;

  const ReaderImageDialog({super.key, required this.imageUrl});

  static void show({required String imageUrl}) {
    showDialog(
      context: dashboardNavigationKey.currentContext!,
      builder: (context) => ReaderImageDialog(imageUrl: imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imageUrl.startsWith('/')
                  ? Image.file(File(imageUrl), fit: BoxFit.contain)
                  : CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
