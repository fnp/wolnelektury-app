import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';

class LastReadBookElement extends StatelessWidget {
  final String slug;
  const LastReadBookElement({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingleBookCubit(get.get())..loadBookData(slug: slug),
      child: Builder(
        builder: (context) {
          return BlocBuilder<SingleBookCubit, SingleBookState>(
            buildWhen: (p, c) {
              return p.book != c.book || p.isLoading != c.isLoading;
            },
            builder: (context, state) {
              final shouldHide = !state.isLoading && state.book == null;
              return Skeletonizer(
                enableSwitchAnimation: true,
                enabled: state.isLoading,
                child: shouldHide
                    ? const SizedBox.shrink()
                    : BookPageCoverWithButtons(
                        book: state.book ?? BookModel.empty(),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
