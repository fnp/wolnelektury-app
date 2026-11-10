import 'package:flutter_test/flutter_test.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/utils/reader/quote_selection_resolver.dart';

ReaderBookModelContent _paragraph(String id, String text) {
  return ReaderBookModelContent(
    tag: ReaderBookTag.p,
    id: id,
    contents: [ReaderBookText(text)],
  );
}

void main() {
  final p1 = _paragraph('p1', 'Hello world'); // len 11
  final p2 = _paragraph('p2', 'Second paragraph'); // len 16
  final p3 = _paragraph('p3', 'Third one'); // len 9

  group('buildCombinedPlainText', () {
    test('joins segments with a single line break', () {
      expect(
        buildCombinedPlainText([p1, p2, p3]),
        'Hello world\nSecond paragraph\nThird one',
      );
    });
  });

  group('locateSelection', () {
    test('finds an exact match', () {
      expect(locateSelection('Hello world', 'world'), (6, 11));
    });

    test('ignores whitespace differences from rendering', () {
      expect(locateSelection('Line one Line two', 'Line one\nLine two'), (
        0,
        17,
      ));
      expect(locateSelection('ab cd ef', 'cd\nef'), (3, 8));
    });

    test('returns null when the text is not present', () {
      expect(locateSelection('Hello world', 'missing'), isNull);
      expect(locateSelection('Hello world', ' \n'), isNull);
    });
  });

  group('resolveSelection', () {
    test('returns null for empty segments', () {
      expect(resolveSelection(segments: [], start: 0, end: 1), isNull);
    });

    test('returns null for invalid range', () {
      expect(resolveSelection(segments: [p1], start: 3, end: 3), isNull);
      expect(resolveSelection(segments: [p1], start: -1, end: 3), isNull);
    });

    test(
      'single segment selection matches original single-paragraph behavior',
      () {
        final result = resolveSelection(segments: [p1], start: 0, end: 5);
        expect(result!.startElem, 'p1');
        expect(result.startOffset, 0);
        expect(result.endElem, 'p1');
        expect(result.endOffset, 5);
      },
    );

    test('selection entirely within the middle segment', () {
      // "Second paragraph" starts at index 12 in the combined text.
      final result = resolveSelection(
        segments: [p1, p2, p3],
        start: 12,
        end: 18,
      );
      expect(result!.startElem, 'p2');
      expect(result.startOffset, 0);
      expect(result.endElem, 'p2');
      expect(result.endOffset, 6);
    });

    test('selection spanning segment 1 into segment 2', () {
      // starts inside "Hello world" (index 6 -> 'w'), ends inside "Second paragraph".
      final result = resolveSelection(
        segments: [p1, p2, p3],
        start: 6,
        end: 18,
      );
      expect(result!.startElem, 'p1');
      expect(result.startOffset, 6);
      expect(result.endElem, 'p2');
      expect(result.endOffset, 6);
      expect(result.text, 'world\nSecond');
    });

    test('text of a single-segment selection', () {
      final result = resolveSelection(segments: [p1], start: 0, end: 5);
      expect(result!.text, 'Hello');
    });

    test('selection spanning segment 2 into segment 3', () {
      final combined = buildCombinedPlainText([p1, p2, p3]);
      final start = combined.indexOf('paragraph');
      final end = combined.indexOf('one') + 3;
      final result = resolveSelection(
        segments: [p1, p2, p3],
        start: start,
        end: end,
      );
      expect(result!.startElem, 'p2');
      expect(result.endElem, 'p3');
    });

    test('selection spanning the full range 1 to 3', () {
      final combined = buildCombinedPlainText([p1, p2, p3]);
      final result = resolveSelection(
        segments: [p1, p2, p3],
        start: 0,
        end: combined.length,
      );
      expect(result!.startElem, 'p1');
      expect(result.startOffset, 0);
      expect(result.endElem, 'p3');
      expect(result.endOffset, 9);
    });

    test('start exactly on a separator snaps forward to next segment', () {
      // Position 11 is the '\n' separator right after "Hello world".
      final result = resolveSelection(
        segments: [p1, p2, p3],
        start: 11,
        end: 14,
      );
      expect(result!.startElem, 'p2');
      expect(result.startOffset, 0);
    });

    test('end exactly on a separator snaps backward to previous segment', () {
      // end = 12 means last selected char index 11, which is the separator.
      final result = resolveSelection(
        segments: [p1, p2, p3],
        start: 6,
        end: 12,
      );
      expect(result!.endElem, 'p1');
      expect(result.endOffset, 11);
    });

    test('offsets exclude the leading paragraph indent', () {
      const indented = ReaderBookModelContent(
        tag: ReaderBookTag.p,
        id: 'p4',
        paragraphIndex: 0,
        contents: [ReaderBookText('Indented text')],
      );
      final combined = buildCombinedPlainText([indented]);
      expect(combined, '${indentFor(indented)}Indented text');

      final start = combined.indexOf('Indented');
      final end = combined.length;
      final result = resolveSelection(
        segments: [indented],
        start: start,
        end: end,
      );
      expect(result!.startElem, 'p4');
      expect(result.startOffset, 0);
      expect(result.endElem, 'p4');
      expect(result.endOffset, 'Indented text'.length);
    });

    test('selection starting inside the indent clamps to offset 0', () {
      const indented = ReaderBookModelContent(
        tag: ReaderBookTag.p,
        id: 'p5',
        paragraphIndex: 0,
        contents: [ReaderBookText('Indented text')],
      );
      final result = resolveSelection(
        segments: [indented],
        start: 0,
        end: indentFor(indented).length + 5,
      );
      expect(result!.startElem, 'p5');
      expect(result.startOffset, 0);
    });
  });
}
