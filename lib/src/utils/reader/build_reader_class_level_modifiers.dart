import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';

class BuildReaderClassLevelModifiers {
  static InlineSpan build(
    String text,
    TextStyle style,
    String fontFamily,
    double fontSize,
    // Classname of the element itself
    String? className,
    // Classname of the parent element
    String? parentClass,
    // This is whole sibling element, n+1 from the current element contents
    dynamic sibling,
  ) {
    final effStyle = style.copyWith(
      fontSize: fontSize,
      fontFamily: fontFamily,
    );

    // print('Text: $text of class: $className and parent class: $parentClass');

    switch (parentClass) {
      // Text is italic and has padding
      case 'motto':
        return _widgetSpanWithPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: Text(
            text,
            style: effStyle.copyWith(fontStyle: FontStyle.italic),
          ),
        );
      // Text is italic and has padding
      // and is aligned to the right
      case 'note':
        return _widgetSpanWithPadding(
          padding: EdgeInsets.zero,
          child: Text(
            text,
            textAlign: TextAlign.end,
            style: effStyle.copyWith(fontStyle: FontStyle.italic),
          ),
        );
    }

    switch (className) {
      case 'verse':
      //todo should it have double indent?
      case 'wers_cd':
        // Verse has sibling next to it, probably styled text, do not insert new line
        if (sibling != null) {
          return TextSpan(text: text, style: effStyle);
        }
        // Creates a new line of text for each verse
        return TextSpan(text: '$text\n', style: effStyle);
      case 'wers_wciety':
        // Verse has sibling next to it, probably styled text, do not insert new line
        if (sibling != null) {
          return TextSpan(text: '$textIndent$text', style: effStyle);
        }
        // Creates a new line of text for each verse
        if (text.length > 1) {
          return TextSpan(text: '$textIndent$text\n', style: effStyle);
        }
        // Probably comma or dot, do not insert text indent, happens after footnotes etc
        return TextSpan(text: '$text\n', style: effStyle);

      case 'naglowek_listy':
        return WidgetSpan(
          child: Row(
            children: [
              Text(text, style: effStyle.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        );

      case 'osoba':
        if (parentClass == 'lista_osoba') {
          return TextSpan(
            text: text.toLowerCase(),
            style: effStyle.copyWith(
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
              style: effStyle.copyWith(
                fontFeatures: [const FontFeature.enable('smcp')],
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        );

      case 'spacer-asterisk':
        return _widgetSpanWithPadding(
          mainAxisAlignment: MainAxisAlignment.center,
          padding: EdgeInsets.zero,
          child: Text(text, style: effStyle),
        );

      case 'separator_linia':
        return const WidgetSpan(
          child: Divider(thickness: 1, color: Colors.grey),
        );

      case 'didaskalia':
        return TextSpan(
          text: text,
          style: effStyle.copyWith(
            fontStyle: FontStyle.italic,
          ),
        );
    }

    return TextSpan(text: text, style: effStyle);
  }

  static WidgetSpan _widgetSpanWithPadding({
    required EdgeInsets padding,
    required Widget child,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    return WidgetSpan(
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
