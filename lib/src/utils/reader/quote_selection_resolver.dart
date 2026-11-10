import 'package:collection/collection.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_indent.dart';

/// Line break rendered between consecutive paragraphs in the quote sheet
/// preview. Must match exactly what [buildCombinedPlainText] inserts, so
/// selection offsets computed against the combined text stay valid.
const String quoteSegmentSeparator = '\n';

/// Extracted paragraph identifiers/offsets needed to persist a quote.
class QuoteSelectionResult {
  final String startElem;
  final int startOffset;
  final String endElem;
  final int endOffset;

  /// Selected text as plain text (no leading indents), paragraphs joined with
  /// [quoteSegmentSeparator]. Sent to the API alongside the offsets.
  final String text;

  const QuoteSelectionResult({
    required this.startElem,
    required this.startOffset,
    required this.endElem,
    required this.endOffset,
    required this.text,
  });
}

/// Recursively extracts the plain text of [element], skipping `<a>` subtrees
/// since those render as icon-only WidgetSpans with no text output.
String extractPlainText(ReaderBookModelContent element) {
  final buffer = StringBuffer();
  for (final item in element.contents) {
    if (item is ReaderBookText) {
      buffer.write(item.text);
    } else if (item is ReaderBookModelContent) {
      if (item.tag == ReaderBookTag.a) continue;
      buffer.write(extractPlainText(item));
    }
  }
  return buffer.toString();
}

/// Leading indent rendered before a segment's own text, matching the indent
/// `ReaderParagraph` applies to on-page paragraphs.
String indentFor(ReaderBookModelContent element) {
  return element.paragraphIndex != null ? BuildReaderIndent.textIndent : '';
}

/// The text as it's literally rendered for a segment: leading indent + content.
String _displayText(ReaderBookModelContent element) {
  return indentFor(element) + extractPlainText(element);
}

/// Joins the displayed text of each segment with [quoteSegmentSeparator],
/// mirroring the literal separator inserted between paragraphs in the
/// rendered preview.
String buildCombinedPlainText(List<ReaderBookModelContent> segments) {
  return segments.map(_displayText).join(quoteSegmentSeparator);
}

/// Finds the `[start, end)` range of [selected] within [fullText].
///
/// Tries an exact match first. The rendered text can differ from the model
/// text in whitespace only (e.g. line breaks added after verses), so falls
/// back to a match that ignores whitespace. Returns null if nothing matches.
(int start, int end)? locateSelection(String fullText, String selected) {
  if (selected.isEmpty) return null;
  final exact = fullText.indexOf(selected);
  if (exact != -1) return (exact, exact + selected.length);

  final whitespace = RegExp(r'\s');
  final compactSelected = selected.replaceAll(whitespace, '');
  if (compactSelected.isEmpty) return null;

  final compact = StringBuffer();
  final originalIndexes = <int>[];
  for (var i = 0; i < fullText.length; i++) {
    if (whitespace.hasMatch(fullText[i])) continue;
    compact.write(fullText[i]);
    originalIndexes.add(i);
  }
  final compactStart = compact.toString().indexOf(compactSelected);
  if (compactStart == -1) return null;
  final compactEnd = compactStart + compactSelected.length;
  return (originalIndexes[compactStart], originalIndexes[compactEnd - 1] + 1);
}

class _SegmentRange {
  final ReaderBookModelContent element;
  final int start;
  final int end;
  final int indentLength;

  const _SegmentRange(this.element, this.start, this.end, this.indentLength);
}

List<_SegmentRange> _segmentRanges(List<ReaderBookModelContent> segments) {
  final ranges = <_SegmentRange>[];
  var cursor = 0;
  for (final segment in segments) {
    final indentLength = indentFor(segment).length;
    final displayLength = indentLength + extractPlainText(segment).length;
    ranges.add(
      _SegmentRange(segment, cursor, cursor + displayLength, indentLength),
    );
    cursor += displayLength + quoteSegmentSeparator.length;
  }
  return ranges;
}

/// Maps a `[start, end)` selection range within the combined plain text of
/// [segments] back to the per-paragraph element ids and local offsets needed
/// by the quotes API. A position landing exactly on a paragraph separator
/// snaps forward (for [start]) or backward (for [end]) to the adjacent
/// paragraph, so the separator itself is never attributed to either side.
/// Returns null if [segments] is empty, the range is invalid, or a resolved
/// element has no id.
QuoteSelectionResult? resolveSelection({
  required List<ReaderBookModelContent> segments,
  required int start,
  required int end,
}) {
  if (segments.isEmpty || start < 0 || end <= start) return null;
  final ranges = _segmentRanges(segments);

  // Range containing pos as one of its own characters, or null if pos falls
  // in a separator gap (or outside all ranges).
  _SegmentRange? containing(int pos) {
    for (final range in ranges) {
      if (pos >= range.start && pos < range.end) return range;
    }
    return null;
  }

  final startRange =
      containing(start) ?? ranges.firstWhereOrNull((r) => r.start > start);
  final lastCharPos = end - 1;
  final endRange =
      containing(lastCharPos) ??
      ranges.lastWhereOrNull((r) => r.end <= lastCharPos);
  if (startRange == null || endRange == null) return null;

  final startElem = startRange.element.id;
  final endElem = endRange.element.id;
  if (startElem == null || endElem == null) return null;

  // Offsets exclude the leading indent, so a position landing inside it
  // (e.g. selection starts right before the paragraph's real text) clamps to 0.
  final startRealLength =
      startRange.end - startRange.start - startRange.indentLength;
  final startOffset = containing(start) != null
      ? (start - startRange.start - startRange.indentLength).clamp(
          0,
          startRealLength,
        )
      : 0;
  final endRealLength = endRange.end - endRange.start - endRange.indentLength;
  final endOffset = containing(lastCharPos) != null
      ? (end - endRange.start - endRange.indentLength).clamp(0, endRealLength)
      : endRealLength;

  final startIndex = ranges.indexOf(startRange);
  final endIndex = ranges.indexOf(endRange);
  final textParts = <String>[];
  for (var i = startIndex; i <= endIndex; i++) {
    final plain = extractPlainText(ranges[i].element);
    final from = i == startIndex ? startOffset : 0;
    final to = i == endIndex ? endOffset : plain.length;
    textParts.add(
      plain.substring(from.clamp(0, plain.length), to.clamp(0, plain.length)),
    );
  }

  return QuoteSelectionResult(
    startElem: startElem,
    startOffset: startOffset,
    endElem: endElem,
    endOffset: endOffset,
    text: textParts.join(quoteSegmentSeparator),
  );
}
