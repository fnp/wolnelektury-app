import 'package:flutter/material.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_class_level_modifiers.dart';

class BuildReaderTagLevelModifiers {
  static List<InlineSpan> build({
    required String text,
    required ReaderBookModelContent element,
    ReaderBookModelContent? parent,
    required String fontFamily,
    required double fontSize,
    required ThemeData theme,
    required bool isRecursive,
    dynamic sibling,
  }) {
    final parentClassName = parent?.attr?['class'];
    final className = element.attr?['class'];
    final spans = <InlineSpan>[];

    switch (element.tag) {
      case ReaderBookTag.h2:
        spans.addAll([
          const WidgetSpan(
            child: Row(
              children: [
                SizedBox(height: 40),
              ],
            ),
          ),
          BuildReaderClassLevelModifiers.build(
            text,
            theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            fontFamily,
            fontSize,
            className,
            parentClassName,
            sibling,
          ),
          const WidgetSpan(
            child: Row(
              children: [
                SizedBox(height: 40),
              ],
            ),
          ),
        ]);
        break;
      case ReaderBookTag.h3:
        spans.addAll([
          const WidgetSpan(
            child: Row(
              children: [
                SizedBox(height: 20),
              ],
            ),
          ),
          BuildReaderClassLevelModifiers.build(
            text,
            theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            fontFamily,
            fontSize,
            className,
            parentClassName,
            sibling,
          ),
          const WidgetSpan(
            child: Row(
              children: [
                SizedBox(height: 20),
              ],
            ),
          ),
        ]);
        break;
      case ReaderBookTag.h4:
        spans.addAll([
          const WidgetSpan(
            child: Row(
              children: [
                SizedBox(height: 10),
              ],
            ),
          ),
          BuildReaderClassLevelModifiers.build(
            text,
            theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            fontFamily,
            fontSize,
            className,
            parentClassName,
            sibling,
          ),
          const WidgetSpan(
            child: Row(
              children: [
                SizedBox(height: 10),
              ],
            ),
          ),
        ]);
        break;
      case ReaderBookTag.h5:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            text,
            theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            fontFamily,
            fontSize,
            className,
            parentClassName,
            sibling,
          ),
        );
        break;
      case ReaderBookTag.p:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            // Missing textIndent in recursive calls
            isRecursive && text.length > 1 ? '$textIndent$text' : text,
            theme.textTheme.bodyMedium!,
            fontFamily,
            fontSize,
            className,
            parentClassName,
            sibling,
          ),
        );
        break;
      case ReaderBookTag.a:
      case ReaderBookTag.blockquote:
      case ReaderBookTag.div:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            text,
            theme.textTheme.bodyMedium!,
            fontFamily,
            fontSize,
            className,
            parentClassName,
            sibling,
          ),
        );
        break;
      case ReaderBookTag.em:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            text,
            theme.textTheme.bodyMedium!.copyWith(
              fontStyle: FontStyle.italic,
            ),
            fontFamily,
            fontSize,
            className,
            parentClassName,
            sibling,
          ),
        );
        break;
      default:
        spans.add(
          BuildReaderClassLevelModifiers.build(
            '[Unsupported tag: ${element.tag}]',
            theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
            fontFamily,
            fontSize,
            null,
            null,
            sibling,
          ),
        );
        break;
    }

    return spans;
  }
}
