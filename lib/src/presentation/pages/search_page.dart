import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/data/search_repository.dart';
import 'package:wolnelektury/src/presentation/cubits/search/search_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_bar.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_hints.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => SearchCubit(get.get<SearchRepository>()),
      child: Material(
        child: ColoredBox(
          color: theme.scaffoldBackgroundColor,
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
                vertical: Dimensions.spacer,
              ),
              child: Column(
                children: [
                  SearchBar(),
                  SizedBox(height: Dimensions.mediumPadding),
                  SearchHints(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
