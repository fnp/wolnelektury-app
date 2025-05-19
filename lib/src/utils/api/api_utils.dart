import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/presentation/enums/sort_enum.dart';

class ApiUtils {
  static String applySorting({required SortEnum sort, required String apiUrl}) {
    switch (sort) {
      case SortEnum.alphabeticallyAsc:
        return apiUrl;
      case SortEnum.alphabeticallyDesc:
      case SortEnum.popularityAsc:
      case SortEnum.popularityDesc:
        if (apiUrl.contains('?')) {
          return '$apiUrl&sort=${sort.value}';
        }
        return '$apiUrl?sort=${sort.value}';
    }
  }

  static String applyLimit({
    required String apiUrl,
    required int limit,
  }) {
    if (apiUrl.contains('?')) {
      return '$apiUrl&limit=$limit';
    }
    return '$apiUrl?limit=$limit';
  }

  static String applyTags({
    required String apiUrl,
    List<TagModel> tags = const <TagModel>[],
  }) {
    if (tags.isEmpty) return apiUrl;

    final queryParams = tags.map((tag) => 'tag=${tag.id}').join('&');
    if (apiUrl.contains('?')) {
      return '$apiUrl&$queryParams';
    }
    return '$apiUrl/?$queryParams';
  }

  static String applySearch({required String apiUrl, required String? search}) {
    if (search == null) return apiUrl;
    if (apiUrl.contains('?')) {
      return '$apiUrl&search=$search';
    }
    return '$apiUrl?search=$search';
  }
}
