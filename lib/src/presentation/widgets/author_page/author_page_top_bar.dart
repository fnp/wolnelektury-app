import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/detailed_author_model.dart';
import 'package:wolnelektury/src/presentation/cubits/author/author_cubit.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AuthorPageTopBar extends StatelessWidget {
  const AuthorPageTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorCubit, AuthorState>(
      buildWhen: (p, c) {
        return p.isLoading != c.isLoading || p.author != c.author;
      },
      builder: (context, state) {
        if (!state.isLoading && state.author == null) {
          return const Text('Nie znaleziono autora');
        }
        final effAuthor = state.isLoading
            ? DetailedAuthorModel.skeletonized()
            : state.author!;
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: state.isLoading,
          child: _Body(author: effAuthor),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DetailedAuthorModel author;
  const _Body({required this.author});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: Dimensions.mediumPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox.square(
                dimension: constraints.maxWidth,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: Dimensions.mediumPadding,
              ),
              if ((author.description ?? '').isNotEmpty)
                Html(data: author.description),
            ],
          ),
        ),
      ],
    );
  }
}
