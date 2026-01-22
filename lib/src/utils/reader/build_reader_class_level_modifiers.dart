import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_indent.dart';

class BuildReaderClassLevelModifiers {
  static InlineSpan build(
    String text,
    TextStyle style,
    // Classname of the element itself
    String? className,
    // Classname of the parent element
    String? parentClass,
    // This is whole nextSibling element, n+1 from the current element contents
    dynamic nextSibling,
    // This is whole previousSibling element, n-1 from the current element contents
    dynamic prevSibling,
  ) {
    // print(
    //   'Text: $text of class: $className and parent class: $parentClass, and nextSibling: ${nextSibling is ReaderBookModelContent ? nextSibling.tag : nextSibling}, and prevSibling: ${prevSibling is ReaderBookModelContent ? prevSibling.tag : prevSibling}',
    // );

    switch (parentClass) {
      // Text is italic and has padding
      case 'motto':
        return _widgetSpanWithPadding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(text, style: style.copyWith(fontStyle: FontStyle.italic)),
        );
      // Text is italic and has padding
      // and is aligned to the right
      case 'note':
        return _widgetSpanWithPadding(
          padding: EdgeInsets.zero,
          child: Text(
            text,
            textAlign: TextAlign.end,
            style: style.copyWith(fontStyle: FontStyle.italic),
          ),
        );
    }

    switch (className) {
      case 'verse':
      case 'wers_cd':
        // Verse has nextSibling next to it, probably styled text, do not insert new line
        if (nextSibling != null) {
          return TextSpan(text: text, style: style);
        }
        // Creates a new line of text for each verse
        return TextSpan(text: '$text\n', style: style);
      case 'wers_wciety':
        // Verse has nextSibling next to it, probably styled text, do not insert new line
        if (nextSibling != null) {
          return TextSpan(
            text: BuildReaderIndent.applyIndent(text, prevSibling),
            style: style,
          );
        }
        // Creates a new line of text for each verse
        if (text.length > 1) {
          return TextSpan(
            text: '${BuildReaderIndent.applyIndent(text, prevSibling)}\n',
            style: style,
          );
        }
        // Probably comma or dot, do not insert text indent, happens after footnotes etc
        return TextSpan(text: '$text\n', style: style);

      case 'naglowek_listy':
        return WidgetSpan(
          child: Row(
            children: [
              Text(text, style: style.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        );

      case 'osoba':
        if (parentClass == 'lista_osoba') {
          return TextSpan(
            text: text.toLowerCase(),
            style: style.copyWith(
              fontFeatures: [const FontFeature.enable('smcp')],
              fontStyle: FontStyle.normal,
            ),
          );
        }

      case 'naglowek_osoba':
        return WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              text.toLowerCase(),
              style: style.copyWith(
                fontFeatures: [const FontFeature.enable('smcp')],
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        );

      case 'spacer-asterisk':
        return _widgetSpanWithPadding(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: Text('*', style: style),
        );

      case 'separator_linia':
        return const WidgetSpan(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(thickness: 1, color: Colors.grey),
          ),
        );

      case 'didaskalia':
        return TextSpan(
          text: text,
          style: style.copyWith(fontStyle: FontStyle.italic),
        );

      case 'zastepnik_wersu':
        return TextSpan(text: '$text\n', style: style);
    }

    return TextSpan(text: text, style: style);
  }

  static WidgetSpan _widgetSpanWithPadding({
    required EdgeInsets padding,
    required Widget child,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: Padding(
        padding: padding,
        child: Align(alignment: alignment, child: child),
      ),
    );
  }
}
