import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/data/search_repository.dart';
import 'package:wolnelektury/src/presentation/cubits/search/search_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_bar.dart';
import 'package:wolnelektury/src/presentation/widgets/search/search_hints.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(get.get<SearchRepository>()),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.mediumPadding,
          vertical: Dimensions.spacer,
        ),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                children: [
                  SearchBar(),
                  SizedBox(height: Dimensions.mediumPadding),
                  SearchHints(),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: greenElevatedButton,
                    child: const Text('Pokaż wszystkie wyniki'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.spacer),
          ],
        ),
      ),
    );
  }
}
