import 'package:wolnelektury/generated/locale_keys.g.dart';

enum SortEnum {
  alphabeticallyAsc(LocaleKeys.common_sorting_alpha_asc, 'alpha'),
  alphabeticallyDesc(LocaleKeys.common_sorting_alpha_desc, '-alpha'),
  popularityAsc(LocaleKeys.common_sorting_popularity_asc, 'popularity'),
  popularityDesc(LocaleKeys.common_sorting_popularity_desc, '-popularity');

  final String name;
  final String value;
  const SortEnum(this.name, this.value);
}
