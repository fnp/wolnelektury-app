import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/features/audiobooks/widgets/audio_dialog.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';

void onListen({
  required int? timestamp,
  required bool isPlaying,
  required BuildContext context,
  required String slug,
  BookModel? book,
}) {
  if (timestamp == null) {
    return;
  }
  final audioCubit = context.read<AudioCubit>();
  AudioDialog.show(context: context, slug: slug);
  if (isPlaying && audioCubit.state.book?.slug == slug) {
    audioCubit.seekToLocallySelectedPosition(optionalSeconds: timestamp);
  } else {
    if (book != null) {
      audioCubit.pickBook(book, targetTimestamp: timestamp, tryOffline: false);
      return;
    }
    final singleBookCubit = context.read<SingleBookCubit>();
    singleBookCubit
      ..getBookData(
        slug: slug,
        onFinished: (book, isOffline) {
          audioCubit.pickBook(
            book,
            targetTimestamp: timestamp,
            tryOffline: isOffline,
          );
        },
      )
      ..checkIfMediaAreDownloaded(slug);
  }
}
