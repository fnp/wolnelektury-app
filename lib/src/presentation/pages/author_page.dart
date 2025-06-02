import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/author/author_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_books.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_go_back.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_top_bar.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_translations.dart';
import 'package:wolnelektury/src/presentation/widgets/common/load_more_button.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AuthorPage extends StatefulWidget {
  final String? authorSlug;
  const AuthorPage({super.key, this.authorSlug});

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authorSlug == null) {
      //todo error
      return const Text('Nie znaleziono autora');
    }
    return BlocProvider(
      lazy: false,
      create: (context) {
        return AuthorCubit(get.get())..getAuthor(widget.authorSlug!);
      },
      child: Padding(
        padding: const EdgeInsets.all(
          Dimensions.mediumPadding,
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: const [
            SliverToBoxAdapter(child: AuthorPageTopBar()),
            SliverToBoxAdapter(
              child: SizedBox(
                height: Dimensions.spacer,
              ),
            ),
            AuthorPageBooks(),
            SliverToBoxAdapter(
              child: _BooksLoadMore(),
            ),
            SliverToBoxAdapter(
              child: _TranslationsHeader(),
            ),
            AuthorPageTranslations(),
            SliverToBoxAdapter(
              child: _TranslationsLoadMore(),
            ),
            SliverToBoxAdapter(
              child: AuthorPageGoBack(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TranslationsHeader extends StatelessWidget {
  const _TranslationsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthorCubit, AuthorState>(
      buildWhen: (p, c) {
        return p.authorsTranslations != c.authorsTranslations;
      },
      builder: (context, state) {
        if (state.authorsTranslations.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.spacer,
            horizontal: Dimensions.mediumPadding,
          ),
          child: Text(
            LocaleKeys.catalogue_author_translations.tr().toUpperCase(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }
}

class _BooksLoadMore extends StatelessWidget {
  const _BooksLoadMore();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorCubit, AuthorState>(
      buildWhen: (p, c) {
        return p.isLoadingAuthorsBooks != c.isLoadingAuthorsBooks ||
            p.authorsBooksPagination != c.authorsBooksPagination;
      },
      builder: (context, state) {
        if (state.authorsBooksPagination.next == null) {
          return const SizedBox.shrink();
        }
        final cubit = BlocProvider.of<AuthorCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.mediumPadding,
          ),
          child: LoadMoreButton(
            isLoading: state.isLoadingAuthorsBooks,
            onLoadMore: () {
              if (state.isLoadingAuthorsBooks) return;
              cubit.loadMoreBooks();
            },
          ),
        );
      },
    );
  }
}

class _TranslationsLoadMore extends StatelessWidget {
  const _TranslationsLoadMore();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorCubit, AuthorState>(
      buildWhen: (p, c) {
        return p.isLoadingAuthorsTranslations !=
                c.isLoadingAuthorsTranslations ||
            p.authorsTranslationsPagination != c.authorsTranslationsPagination;
      },
      builder: (context, state) {
        if (state.authorsTranslationsPagination.next == null) {
          return const SizedBox.shrink();
        }
        final cubit = BlocProvider.of<AuthorCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.mediumPadding,
          ),
          child: LoadMoreButton(
            isLoading: state.isLoadingAuthorsTranslations,
            onLoadMore: () {
              if (state.isLoadingAuthorsTranslations) return;
              cubit.loadMoreTranslations();
            },
          ),
        );
      },
    );
  }
}
