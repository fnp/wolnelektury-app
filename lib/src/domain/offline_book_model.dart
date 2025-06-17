import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';

part 'offline_book_model.freezed.dart';
part 'offline_book_model.g.dart';

@freezed
sealed class OfflineBookModel with _$OfflineBookModel {
  const factory OfflineBookModel({
    required BookModel book,
    AudiobookModel? audiobook,
  }) = _OfflineBookModel;

  factory OfflineBookModel.fromJson(Map<String, dynamic> json) =>
      _$OfflineBookModelFromJson(json);
}
