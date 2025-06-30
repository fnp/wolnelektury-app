enum ReaderBookTag {
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

class ReaderBookModelContent {
  final ReaderBookTag tag;
  final Map<String, dynamic>? attr;
  final List<dynamic> contents;
  final int? paragraphIndex;
  final int? visibleNumber;

  ReaderBookModelContent({
    required this.tag,
    required this.contents,
    this.attr,
    this.paragraphIndex,
    this.visibleNumber,
  });

  factory ReaderBookModelContent.fromJson(Map<String, dynamic> json) {
    return ReaderBookModelContent(
      tag: ReaderBookTag.fromString(json['tag'] ?? 'unknown'),
      attr: json['attr'],
      contents:
          (json['contents'] as List<dynamic>?)
              ?.map(
                (item) => item is Map<String, dynamic>
                    ? ReaderBookModelContent.fromJson(item)
                    : item.toString(),
              )
              .toList() ??
          [],
      paragraphIndex: json['paragraphIndex'],
      visibleNumber: json['visibleNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag.name,
      'attr': attr,
      'contents': contents
          .map((item) => item is ReaderBookModelContent ? item.toJson() : item)
          .toList(),
      'paragraphIndex': paragraphIndex,
      'visibleNumber': visibleNumber,
    };
  }
}

class ReaderBookModel {
  final ReaderBookModelContent? headerLeft;
  final ReaderBookModelContent? headerRight;
  final List<ReaderBookModelContent> contents;

  ReaderBookModel({required this.contents, this.headerLeft, this.headerRight});

  factory ReaderBookModel.fromJson(Map<String, dynamic> json) {
    return ReaderBookModel(
      headerLeft: (json['front1'] as List).firstOrNull != null
          ? ReaderBookModelContent.fromJson(json['front1'].first)
          : null,
      headerRight: (json['front2'] as List).firstOrNull != null
          ? ReaderBookModelContent.fromJson(json['front2'].first)
          : null,
      contents: (json['contents'] as List)
          .map((item) => ReaderBookModelContent.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contents': contents.map((content) => content.toJson()).toList(),
      'front1': headerLeft != null ? [headerLeft!.toJson()] : [],
      'front2': headerRight != null ? [headerRight!.toJson()] : [],
    };
  }
}
