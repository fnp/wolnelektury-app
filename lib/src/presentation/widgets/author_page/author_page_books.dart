import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/author/author_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_list.dart';

class AuthorPageBooks extends StatelessWidget {
  const AuthorPageBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorCubit, AuthorState>(
      buildWhen: (p, c) {
        return p.authorsBooks != c.authorsBooks;
      },
      builder: (context, state) {
        return BookList(isLoading: false, books: state.authorsBooks);
      },
    );
  }
}
