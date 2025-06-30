import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';

part 'offline_book_model.freezed.dart';
part 'offline_book_model.g.dart';

@freezed
sealed class OfflineBookModel with _$OfflineBookModel {
  const factory OfflineBookModel({
    required BookModel book,
    @Default(false) bool isAudiobookCorrectlyDownloaded,
    AudiobookModel? audiobook,
    ReaderBookModel? reader,
    // updated_at, created_at, wysylac tylko te co mają jedno z tych dwóch pól
    // wysyłać bulkiem, zarządzenie nimi po stronie backendu
    // Zakladki
    // Progressy
  }) = _OfflineBookModel;

  factory OfflineBookModel.fromJson(Map<String, dynamic> json) =>
      _$OfflineBookModelFromJson(json);
}
