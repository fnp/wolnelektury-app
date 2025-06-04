import 'package:freezed_annotation/freezed_annotation.dart';

part 'detailed_author_model.freezed.dart';
part 'detailed_author_model.g.dart';

@freezed
sealed class DetailedAuthorModel with _$DetailedAuthorModel {
  const factory DetailedAuthorModel({
    required int id,
    required String name,
    required String slug,
    String? description,
    String? photo,
  }) = _DetailedAuthorModel;

  factory DetailedAuthorModel.skeletonized() => const DetailedAuthorModel(
        id: 0,
        name: 'Autor',
        slug: 'slug',
        description: 'Opis autora',
        photo: null,
      );

  factory DetailedAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$DetailedAuthorModelFromJson(json);
}
