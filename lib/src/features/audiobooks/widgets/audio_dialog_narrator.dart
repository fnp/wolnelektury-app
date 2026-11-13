import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';

/// Shows who reads the currently played part of the audiobook.
class AudioDialogNarrator extends StatelessWidget {
  const AudioDialogNarrator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AudioCubit, AudioState>(
      buildWhen: (p, c) {
        return p.audiobook != c.audiobook ||
            p.currentlyPlayingPart != c.currentlyPlayingPart;
      },
      builder: (context, state) {
        final parts = state.parts;
        if (parts.isEmpty) return const SizedBox.shrink();
        final part =
            parts[state.currentlyPlayingPart.clamp(0, parts.length - 1)];
        final narrator = part.artist.trim();
        if (narrator.isEmpty) return const SizedBox.shrink();

        return Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.audio_dialog_narrator.tr(
                  namedArgs: {'narrator': narrator},
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
