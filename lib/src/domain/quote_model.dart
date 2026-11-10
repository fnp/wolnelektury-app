import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/book_model.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
sealed class QuoteModel with _$QuoteModel {
  const factory QuoteModel({
    String? uuid,
    @Default('') String text,
    required BookModel book,
    @JsonKey(name: 'book_slug') String? bookSlug,
    @JsonKey(name: 'start_elem') String? startElem,
    @JsonKey(name: 'end_elem') String? endElem,
    @JsonKey(name: 'start_offset') int? startOffset,
    @JsonKey(name: 'end_offset') int? endOffset,

    required String href,

    // These fields are optional and used for syncing purposes.
    int? timestamp,
    @Default(false) bool deleted,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteModelFromJson(json);

  factory QuoteModel.skeletonized() {
    return QuoteModel(
      text: BoneMock.longParagraph,
      book: BookModel.skeletonized(),
      href: BoneMock.name,
    );
  }
}

/// Quotes created offline use an id with this prefix (also as their model
/// uuid) until the server assigns a real uuid during sync.
const String localQuoteIdPrefix = 'local-';

extension QuoteModelX on QuoteModel {
  /// Quotes that exist on the server. Only those can be added to lists.
  bool get isSynced => uuid != null && !uuid!.startsWith(localQuoteIdPrefix);
}
