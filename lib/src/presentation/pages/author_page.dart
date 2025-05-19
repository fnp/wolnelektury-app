import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/author/author_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_books.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_go_back.dart';
import 'package:wolnelektury/src/presentation/widgets/author_page/author_page_top_bar.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated_box_fade.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

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
      create: (context) =>
          AuthorCubit(get.get())..getAuthor(widget.authorSlug!),
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
              child: AuthorPageGoBack(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: Dimensions.spacer,
              ),
            ),
          ],
        ),
      ),
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
        final theme = Theme.of(context);
        final cubit = BlocProvider.of<AuthorCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.mediumPadding,
          ),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimensions.borderRadiusOfCircle,
                ),
              ),
            ),
            child: InkWellWrapper(
              onTap: () {
                if (state.isLoadingAuthorsBooks) return;
                cubit.loadMoreBooks();
              },
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  Dimensions.borderRadiusOfCircle,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.mediumPadding),
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: AnimatedBoxFade(
                        isChildVisible: !state.isLoadingAuthorsBooks,
                        duration: const Duration(milliseconds: 200),
                        collapsedChild: const CustomLoader(),
                        child: Text(
                          'Wczytaj więcej',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(CustomIcons.expand_circle_down),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
