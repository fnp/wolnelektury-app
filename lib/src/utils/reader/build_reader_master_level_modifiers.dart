import 'package:flutter/widgets.dart';

WidgetSpan buildMasterLevelRow({
  required List<InlineSpan>? children,
  required TextStyle style,
  EdgeInsets padding = EdgeInsets.zero,
  TextAlign textAlign = TextAlign.start,
}) {
  return WidgetSpan(
    child: Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(style: style, children: children),
              textAlign: textAlign,
            ),
          ),
        ],
      ),
    ),
  );
}
