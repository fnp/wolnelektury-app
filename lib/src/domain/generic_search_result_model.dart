import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/domain/detailed_author_model.dart';
import 'package:wolnelektury/src/domain/genre_model.dart';

part 'generic_search_result_model.freezed.dart';
part 'generic_search_result_model.g.dart';

@freezed
sealed class GenericSearchResultModel with _$GenericSearchResultModel {
  const factory GenericSearchResultModel({
    @Default([]) List<DetailedAuthorModel> author,
    @Default([]) List<GenreModel> genre,
    //todo theme?
  }) = _GenericSearchResultModel;

  factory GenericSearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$GenericSearchResultModelFromJson(json);
}
