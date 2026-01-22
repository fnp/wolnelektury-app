import 'package:flutter/material.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_class_level_modifiers.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_indent.dart';

class BuildReaderTagLevelModifiers {
  static List<InlineSpan> build({
    required String text,
    required ReaderBookModelContent element,
    ReaderBookModelContent? parent,
    required String fontFamily,
    required double fontSize,
    required double fontHeight,
    required ThemeData theme,
    required bool isRecursive,
    dynamic nextSibling,
    dynamic prevSibling,
  }) {
    final parentClassName = parent?.attr?['class'];
    final className = element.attr?['class'];
    final spans = <InlineSpan>[];

    // Helper for vertical spacing
    InlineSpan spacer(double height) => WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: SizedBox(height: height),
    );

    TextStyle baseStyle = theme.textTheme.bodyMedium!.copyWith(
      fontFamily: fontFamily,
      fontSize: fontSize,
      height: fontHeight,
    );

    switch (element.tag) {
      case ReaderBookTag.h2:
        spans.addAll([
          spacer(40),
          BuildReaderClassLevelModifiers.build(
            text,
            baseStyle.copyWith(fontWeight: FontWeight.bold),
            className,
            parentClassName,
            nextSibling,
            prevSibling,
          ),
          spacer(40),
        ]);
        break;

      case ReaderBookTag.h3:
        spans.addAll([
          spacer(20),
          BuildReaderClassLevelModifiers.build(
            text,
            baseStyle.copyWith(fontWeight: FontWeight.bold),
            className,
            parentClassName,
            nextSibling,
            prevSibling,
          ),
          spacer(20),
        ]);
        break;

      case ReaderBookTag.h4:
        spans.addAll([
          spacer(10),
          BuildReaderClassLevelModifiers.build(
            text,
            baseStyle.copyWith(fontWeight: FontWeight.bold),
            className,
            parentClassName,
            nextSibling,
            prevSibling,
          ),
          spacer(10),
        ]);
        break;

      case ReaderBookTag.h5:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            text,
            baseStyle.copyWith(fontWeight: FontWeight.bold),
            className,
            parentClassName,
            nextSibling,
            prevSibling,
          ),
        );
        break;

      case ReaderBookTag.p:
        final shouldApplyIndent = isRecursive && text.length > 1;
        spans.add(
          BuildReaderClassLevelModifiers.build(
            shouldApplyIndent
                ? BuildReaderIndent.applyIndent(text, prevSibling)
                : text,
            baseStyle,
            className,
            parentClassName,
            nextSibling,
            prevSibling,
          ),
        );
        break;

      case ReaderBookTag.a:
      case ReaderBookTag.blockquote:
      case ReaderBookTag.div:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            text,
            baseStyle,
            className,
            parentClassName,
            nextSibling,
            prevSibling,
          ),
        );
        break;

      case ReaderBookTag.em:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            text,
            baseStyle.copyWith(fontStyle: FontStyle.italic),
            className,
            parentClassName,
            nextSibling,
            prevSibling,
          ),
        );
        break;

      default:
        // spans.add(
        //   BuildReaderClassLevelModifiers.build(
        //     '[Unsupported tag: ${element.tag}]',
        //     baseStyle.copyWith(color: Colors.red),
        //     fontFamily,
        //     fontSize,
        //     null,
        //     null,
        //     nextSibling,
        //     prevSibling,
        //   ),
        // );
        break;
    }

    return spans;
  }
}
