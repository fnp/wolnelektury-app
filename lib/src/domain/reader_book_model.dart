enum ReaderBookTag {
  master,
  p,
  h2,
  h3,
  h4,
  h5,
  blockquote,
  a,
  div,
  em,
  unknown;

  static ReaderBookTag fromString(String value) {
    return ReaderBookTag.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ReaderBookTag.unknown,
    );
  }
}

sealed class ReaderBookContentItem {
  const ReaderBookContentItem();

  dynamic toJson();
  int? get paragraphIndex;

  factory ReaderBookContentItem.fromJson(dynamic json) {
    if (json is String) {
      return ReaderBookText(json);
    } else if (json is Map<String, dynamic>) {
      return ReaderBookModelContent.fromJson(json);
    } else {
      throw ArgumentError('Invalid content type: $json');
    }
  }
}

/// Reprezentuje tekst w treści książki
class ReaderBookText extends ReaderBookContentItem {
  final String text;

  const ReaderBookText(this.text);

  @override
  String toJson() => text;

  @override
  int? get paragraphIndex => null;
}

/// Reprezentuje zagnieżdżony element z tagiem, atrybutami i zawartością
class ReaderBookModelContent extends ReaderBookContentItem {
  final ReaderBookTag tag;
  final String? id;
  final Map<String, dynamic>? attr;
  final List<ReaderBookContentItem> contents;
  @override
  final int? paragraphIndex;
  final int? visibleNumber;

  const ReaderBookModelContent({
    required this.tag,
    required this.contents,
    this.id,
    this.attr,
    this.paragraphIndex,
    this.visibleNumber,
  });

  factory ReaderBookModelContent.fromJson(Map<String, dynamic> json) {
    final rawContents = json['contents'] as List<dynamic>? ?? [];

    return ReaderBookModelContent(
      tag: ReaderBookTag.fromString(json['tag'] ?? 'unknown'),
      id: json['id'] as String?,
      attr: (json['attr'] as Map?)?.cast<String, dynamic>(),
      contents: rawContents
          .map((item) => ReaderBookContentItem.fromJson(item))
          .toList(),
      paragraphIndex: json['paragraphIndex'] as int?,
      visibleNumber: json['visibleNumber'] as int?,
    );
  }

  /// Sprawdza czy ten element lub jego zagnieżdżone elementy zawierają określone ID
  bool containsElementId(String targetId) {
    // Sprawdź czy aktualny element ma szukane ID
    if (id == targetId) {
      return true;
    }

    // Rekurencyjnie sprawdź zagnieżdżone elementy
    for (final content in contents) {
      if (content is ReaderBookModelContent) {
        if (content.containsElementId(targetId)) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'tag': tag.name,
      'contents': contents.map((e) => e.toJson()).toList(),
    };

    if (id != null) result['id'] = id;
    if (attr != null) result['attr'] = attr;
    if (paragraphIndex != null) result['paragraphIndex'] = paragraphIndex;
    if (visibleNumber != null) result['visibleNumber'] = visibleNumber;

    return result;
  }
}

class ReaderBookModel {
  final ReaderBookModelContent? headerLeft;
  final ReaderBookModelContent? headerRight;
  final ReaderBookModelContent masterContent;

  const ReaderBookModel({
    required this.masterContent,
    this.headerLeft,
    this.headerRight,
  });

  factory ReaderBookModel.fromJson(Map<String, dynamic> json) {
    final front1 = json['front1'] as List?;
    final front2 = json['front2'] as List?;

    return ReaderBookModel(
      headerLeft: (front1?.isNotEmpty ?? false)
          ? ReaderBookModelContent.fromJson(front1!.first)
          : null,
      headerRight: (front2?.isNotEmpty ?? false)
          ? ReaderBookModelContent.fromJson(front2!.first)
          : null,
      masterContent: ReaderBookModelContent.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    final result = masterContent.toJson();

    if (headerLeft != null) {
      result['front1'] = [headerLeft!.toJson()];
    }
    if (headerRight != null) {
      result['front2'] = [headerRight!.toJson()];
    }

    return result;
  }

  /// Getter dla wstecznej kompatybilności - zwraca zawartość głównego elementu
  /// Filtruje tylko ReaderBookModelContent, bo główna lista zawiera tylko takie elementy
  List<ReaderBookModelContent> get contents =>
      masterContent.contents.whereType<ReaderBookModelContent>().toList();
}
