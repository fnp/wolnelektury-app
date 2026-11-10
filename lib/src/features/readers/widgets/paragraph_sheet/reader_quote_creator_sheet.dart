import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/features/readers/cubits/quotes/quotes_cubit.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/reader/quote_selection_resolver.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReaderQuoteCreatorSheet extends StatefulWidget {
  final ReaderBookModelContent? previousElement;
  final ReaderBookModelContent element;
  final ReaderBookModelContent? nextElement;
  final BookModel book;
  final String fontFamily;
  final double fontSize;
  final double fontHeight;

  const ReaderQuoteCreatorSheet({
    super.key,
    this.previousElement,
    required this.element,
    this.nextElement,
    required this.book,
    required this.fontFamily,
    required this.fontSize,
    required this.fontHeight,
  });

  static void show({
    ReaderBookModelContent? previousElement,
    required ReaderBookModelContent element,
    ReaderBookModelContent? nextElement,
    required BookModel book,
    required QuotesCubit quotesCubit,
    required String fontFamily,
    required double fontSize,
    required double fontHeight,
  }) {
    showModalBottomSheet(
      context: dashboardNavigationKey.currentContext!,
      useRootNavigator: true,
      isScrollControlled: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      // The cubit outlives the sheet, so the result can be shown as a snackbar.
      builder: (context) => BlocProvider.value(
        value: quotesCubit,
        child: ReaderQuoteCreatorSheet(
          previousElement: previousElement,
          element: element,
          nextElement: nextElement,
          book: book,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontHeight: fontHeight,
        ),
      ),
    );
  }

  @override
  State<ReaderQuoteCreatorSheet> createState() =>
      _ReaderQuoteCreatorSheetState();
}

class _ReaderQuoteCreatorSheetState extends State<ReaderQuoteCreatorSheet>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<(int start, int end)?> _selection = ValueNotifier(null);
  final GlobalKey _anchorKey = GlobalKey();
  final FocusNode _selectionFocusNode = FocusNode();
  late final List<ReaderBookModelContent> _segments = [
    widget.previousElement,
    widget.element,
    widget.nextElement,
  ].whereType<ReaderBookModelContent>().toList();
  late final int _anchorIndex = _segments.indexOf(widget.element);

  // Same breathing-highlight color/alpha as ReaderBreathingBackground, but
  // played once and faded out so it doesn't linger over text selection.
  late final AnimationController _anchorHighlightController =
      AnimationController(
        duration: const Duration(milliseconds: 1600),
        vsync: this,
      );
  late final Animation<double> _anchorHighlightAlpha = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: 0.4,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 30,
    ),
    TweenSequenceItem(tween: ConstantTween(0.4), weight: 25),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.4,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 45,
    ),
  ]).animate(_anchorHighlightController);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final anchorContext = _anchorKey.currentContext;
      if (anchorContext == null) {
        _anchorHighlightController.forward();
        return;
      }
      Scrollable.ensureVisible(
        anchorContext,
        alignment: 0.2,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
        duration: const Duration(milliseconds: 300),
      ).then((_) => _anchorHighlightController.forward());
    });
  }

  @override
  void dispose() {
    _selection.dispose();
    _selectionFocusNode.dispose();
    _anchorHighlightController.dispose();
    super.dispose();
  }

  void _onSelectionChanged(SelectedContent? content) {
    if (content == null || content.plainText.isEmpty) {
      _selection.value = null;
      return;
    }
    // WidgetSpan elements (e.g. footnote icons) are encoded as U+FFFC in
    // SelectedContent.plainText. Strip them so the offset aligns with the
    // plain text extracted from the model (which has no such characters).
    final selectedText = content.plainText.replaceAll('\uFFFC', '');
    if (selectedText.isEmpty) {
      _selection.value = null;
      return;
    }
    final fullText = buildCombinedPlainText(_segments);
    final range = locateSelection(fullText, selectedText);
    _selection.value = range;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      bottom: true,
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 150,
          maxHeight: MediaQuery.of(context).size.height * 0.66,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.veryLargePadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.largePadding,
              ),
              child: Text(
                LocaleKeys.reader_quote_sheet_hint.tr(),
                style: theme.textTheme.labelLarge,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.mediumPadding),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.inverseSurface,
                    borderRadius: BorderRadius.circular(
                      Dimensions.smallBorderRadius,
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimensions.spacer),
                    child: NotificationListener<ScrollStartNotification>(
                      onNotification: (_) {
                        // Dismiss the on-screen selection handles/toolbar once the
                        // user starts scrolling past the selected text.
                        _selectionFocusNode.unfocus();
                        _selection.value = null;
                        return false;
                      },
                      child: SelectionArea(
                        focusNode: _selectionFocusNode,
                        onSelectionChanged: _onSelectionChanged,
                        child: AnimatedBuilder(
                          animation: _anchorHighlightController,
                          builder: (context, _) {
                            return Text.rich(
                              TextSpan(
                                children: [
                                  for (
                                    var i = 0;
                                    i < _segments.length;
                                    i++
                                  ) ...[
                                    if (i > 0)
                                      const TextSpan(
                                        text: quoteSegmentSeparator,
                                      ),
                                    if (i == _anchorIndex)
                                      WidgetSpan(
                                        child: SizedBox.shrink(key: _anchorKey),
                                      ),
                                    if (indentFor(_segments[i]).isNotEmpty)
                                      TextSpan(text: indentFor(_segments[i])),
                                    if (i == _anchorIndex)
                                      TextSpan(
                                        style: TextStyle(
                                          backgroundColor: CustomColors
                                              .primaryYellowColor
                                              .withValues(
                                                alpha:
                                                    _anchorHighlightAlpha.value,
                                              ),
                                        ),
                                        children: buildReaderBase(
                                          theme: theme,
                                          element: _segments[i],
                                          fontFamily: widget.fontFamily,
                                          fontSize: widget.fontSize,
                                          fontHeight: widget.fontHeight,
                                          ignoreIcons: true,
                                        ),
                                      )
                                    else
                                      ...buildReaderBase(
                                        theme: theme,
                                        element: _segments[i],
                                        fontFamily: widget.fontFamily,
                                        fontSize: widget.fontSize,
                                        fontHeight: widget.fontHeight,
                                        ignoreIcons: true,
                                      ),
                                  ],
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
                vertical: Dimensions.mediumPadding,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                  valueListenable: _selection,
                  builder: (context, selection, _) {
                    final resolved = selection != null
                        ? resolveSelection(
                            segments: _segments,
                            start: selection.$1,
                            end: selection.$2,
                          )
                        : null;
                    final canSave = resolved != null;
                    return FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: CustomColors.primaryYellowColor,
                        foregroundColor: CustomColors.black,
                        disabledBackgroundColor: CustomColors.primaryYellowColor
                            .withValues(alpha: 0.4),
                        disabledForegroundColor: CustomColors.black.withValues(
                          alpha: 0.4,
                        ),
                      ),
                      onPressed: canSave
                          ? () {
                              context.read<QuotesCubit>().createQuote(
                                book: widget.book,
                                startElem: resolved.startElem,
                                endElem: resolved.endElem,
                                startOffset: resolved.startOffset,
                                endOffset: resolved.endOffset,
                                text: resolved.text,
                              );
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: Text(LocaleKeys.reader_quote_sheet_save.tr()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
