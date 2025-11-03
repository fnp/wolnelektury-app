import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/books/books_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/sort_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/dropdown/custom_dropdown.dart';

class CatalogueSorting extends StatelessWidget {
  const CatalogueSorting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      buildWhen: (p, c) => p.sort != c.sort,
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomDropdown<SortEnum>(
              highlightButton: state.isAnySortSelected,
              width: constraints.maxWidth,
              items: SortEnum.values
                  .map(
                    (e) => CustomDropdownElement(
                      title: e.name.tr(),
                      element: e,
                      isSelected: e == state.sort,
                      icon: e.icon,
                    ),
                  )
                  .toList(),
              onSelected: (element) {
                BlocProvider.of<BooksCubit>(context).changeSort(element);
              },
              icon: const Icon(Icons.swap_vert),
              label: LocaleKeys.common_icon_button_sort.tr(),
            );
          },
        );
      },
    );
  }
}
