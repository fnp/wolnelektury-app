import 'package:flutter/material.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_bottom_sheet.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_master_level_modifiers.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_tag_level_modifiers.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

/// This works on "levels" of the book model.
/// Zero level is inside build_reader_spans_wrapper.dart, and it applies to the
/// whole functions, things like padding should be done there.
///
/// First level is master level, which contains all the content, used when
/// all the content needs to be adjusted.
///
/// Second level is tag level, which adjust text based on the tag.
///
/// Third level is class level, which adjust text based on either the parent
/// class or child class.
List<InlineSpan> buildReaderBase({
  required ReaderBookModelContent element,
  ReaderBookModelContent? parent,
  required String fontFamily,
  required double fontSize,
  required ThemeData theme,
  bool isRecursive = false,
}) {
  List<InlineSpan> spans = [];
  List<InlineSpan> getSpans(
    dynamic item, {
    dynamic nextSibling,
    dynamic prevSibling,
  }) {
    return _getSpans(
      item: item,
      element: element,
      parent: parent,
      nextSibling: nextSibling,
      prevSibling: prevSibling,
      fontFamily: fontFamily,
      fontSize: fontSize,
      theme: theme,
      isRecursive: isRecursive,
    );
  }

  switch (element.attr?['class']) {
    case 'motto_podpis':
      spans.add(
        buildMasterLevelRow(
          children: element.contents.expand((item) {
            return getSpans(item);
          }).toList(),
          textAlign: TextAlign.end,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
      break;
    case 'miejsce_czas':
      spans.add(
        buildMasterLevelRow(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: element.contents.expand((item) {
            return getSpans(item);
          }).toList(),
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
      break;
    case 'lista_osoba':
      spans.add(
        buildMasterLevelRow(
          children: element.contents.expand((item) {
            return getSpans(item);
          }).toList(),
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontFamily: fontFamily,
          ),
        ),
      );
      break;
    default:
      spans = element.contents.asMap().entries.expand((entry) {
        final index = entry.key;
        final item = entry.value;
        final nextSibling = index + 1 < element.contents.length
            ? element.contents[index + 1]
            : null;
        final prevSibling = index - 1 >= 0 ? element.contents[index - 1] : null;

        return getSpans(
          item,
          nextSibling: nextSibling,
          prevSibling: prevSibling,
        );
      }).toList();
  }

  return spans;
}

List<InlineSpan> _getSpans({
  required dynamic item,
  required ReaderBookModelContent element,
  ReaderBookModelContent? parent,
  dynamic nextSibling,
  dynamic prevSibling,
  required String fontFamily,
  required double fontSize,
  required ThemeData theme,
  required bool isRecursive,
}) {
  if (item is ReaderBookModelContent) {
    if (item.tag == ReaderBookTag.a) {
      return [
        _handleLinkTags(
          element: element,
          linkContent: item,
          fontFamily: fontFamily,
          fontSize: fontSize,
        ),
      ];
    }

    return buildReaderBase(
      element: item,
      parent: element,
      fontFamily: fontFamily,
      fontSize: fontSize,
      theme: theme,
      isRecursive: true,
    );
  }

  if (item is String || item == null) {
    return BuildReaderTagLevelModifiers.build(
      text: item ?? '',
      element: element,
      parent: parent,
      fontFamily: fontFamily,
      fontSize: fontSize,
      theme: theme,
      isRecursive: isRecursive,
      nextSibling: nextSibling,
      prevSibling: prevSibling,
    );
  }

  return [];
}

WidgetSpan _handleLinkTags({
  required ReaderBookModelContent element,
  required ReaderBookModelContent linkContent,
  required String fontFamily,
  required double fontSize,
}) {
  final icons = {
    'footnote footnote-pe': (
      Icons.not_listed_location_sharp,
      CustomColors.secondaryBlueColor,
    ),
    'reference': (Icons.info, CustomColors.secondaryBlueColor),
    // 'theme': (Icons.color_lens, CustomColors.secondaryBlueColor),
  };

  final className = linkContent.attr?['class'];
  if (icons[className] == null) {
    return const WidgetSpan(child: SizedBox.shrink());
  }

  return WidgetSpan(
    child: GestureDetector(
      onTap: () => ReaderBottomSheet.show(
        element: element,
        linkContent: linkContent,
        fontFamily: fontFamily,
        fontSize: fontSize,
        isTheme: className == 'theme',
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Icon(
          icons[className]?.$1,
          size: fontSize + 3,
          color: icons[className]?.$2,
        ),
      ),
    ),
  );
}
