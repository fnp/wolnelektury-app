import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class AudioDialogBookCover extends StatelessWidget {
  final String? bookCoverUrl;
  const AudioDialogBookCover({super.key, required this.bookCoverUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.smallBorderRadius),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 230),
        child: CachedNetworkImage(
          imageUrl: bookCoverUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: SvgPicture.asset(Images.logo)),
        ),
      ),
    );
  }
}
