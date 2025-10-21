import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';

enum SortEnum {
  alphabeticallyAsc(
    LocaleKeys.common_sorting_alpha_asc,
    'alpha',
    Icons.arrow_upward_outlined,
  ),
  alphabeticallyDesc(
    LocaleKeys.common_sorting_alpha_desc,
    '-alpha',
    Icons.arrow_downward_outlined,
  ),
  popularityAsc(
    LocaleKeys.common_sorting_popularity_asc,
    'popularity',
    Icons.arrow_upward_outlined,
  ),
  popularityDesc(
    LocaleKeys.common_sorting_popularity_desc,
    '-popularity',
    Icons.arrow_downward_outlined,
  );

  final String name;
  final String value;
  final IconData icon;
  const SortEnum(this.name, this.value, this.icon);
}
