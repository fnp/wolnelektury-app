import 'package:wolnelektury/src/domain/reader_book_model.dart';

class BuildReaderIndent {
  static const String textIndent = '     ';

  static bool _shouldOmitIndent(ReaderBookModelContent? element) {
    // No sibling element to check against
    if (element == null) return false;
    // Check if the element is a link with class 'footnote footnote-pe' or 'reference'
    if (element.tag == ReaderBookTag.a &&
        (element.attr?['class'] == 'footnote footnote-pe' ||
            element.attr?['class'] == 'reference')) {
      // Omit indent for footnotes and references siblings
      return true;
    }
    return false;
  }

  static String applyIndent(String text, dynamic prevSibling) {
    if (text.trim().isEmpty) return text;
    if (prevSibling is! ReaderBookModelContent) return '$textIndent$text';
    if (_shouldOmitIndent(prevSibling)) return text;
    return '$textIndent$text';
  }
}
