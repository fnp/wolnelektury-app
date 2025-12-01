import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

enum ReaderBottomSheetType { reference, footnote }

class ReaderBottomSheet extends StatefulWidget {
  final ReaderBookModelContent element;
  final ReaderBookModelContent linkContent;
  final String fontFamily;
  final double fontSize;
  final ReaderBottomSheetType type;

  const ReaderBottomSheet({
    super.key,
    required this.element,
    required this.linkContent,
    required this.fontFamily,
    required this.fontSize,
    required this.type,
  });

  static void show({
    required ReaderBookModelContent element,
    required ReaderBookModelContent linkContent,
    required String fontFamily,
    required double fontSize,
    required ReaderBottomSheetType type,
  }) {
    showModalBottomSheet(
      context: dashboardNavigationKey.currentContext!,
      useRootNavigator: true,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return ReaderBottomSheet(
          element: element,
          linkContent: linkContent,
          fontFamily: fontFamily,
          fontSize: fontSize,
          type: type,
        );
      },
    );
  }

  @override
  State<ReaderBottomSheet> createState() => _ReaderBottomSheetState();
}

class _ReaderBottomSheetState extends State<ReaderBottomSheet> {
  WebViewController? controller;

  @override
  Widget build(BuildContext context) {
    final String? link = () {
      final uri = widget.linkContent.attr?['data-uri'];
      if (uri != null && uri is String && uri.isNotEmpty) {
        return uri;
      }

      return null;
    }();

    Widget? child;

    if (link != null && widget.type == ReaderBottomSheetType.reference) {
      controller ??= WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(link));

      child = ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 150,
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: Column(
          children: [Expanded(child: WebViewWidget(controller: controller!))],
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 150,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child:
          child ??
          Padding(
            padding: const EdgeInsets.all(Dimensions.spacer),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: buildReaderBase(
                        theme: Theme.of(context),
                        element: widget.linkContent,
                        parent: widget.element,
                        fontFamily: widget.fontFamily,
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
