import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';

class AppLinksHandler extends StatefulWidget {
  const AppLinksHandler({required Key key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<AppLinksHandler> createState() => _AppLinksHandlerState();
}

class _AppLinksHandlerState extends State<AppLinksHandler>
    with WidgetsBindingObserver {
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks() async {
    // Handle links
    // Testowanie -------------------------------------------------------------------
    // adb shell 'am start -a android.intent.action.VIEW \
    // -c android.intent.category.BROWSABLE \
    // -d "https://wolnelektury.pl/katalog/lektura/tajemniczy-ogrod/"' \
    // pl.app.wolnelektury
    // -------------------------------------------------------------------------------
    _linkSubscription = AppLinks().uriLinkStream.listen((uri) {
      openAppLink(uri);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initDeepLinks();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _linkSubscription?.cancel();
    super.dispose();
  }

  void openAppLink(Uri uri) {
    // --------------------------------------------
    // otwieranie apki na akapicie czytnika
    // otwieranie apki z odtworzeniem audiobooka
    // LUB
    // otworzenie apki z widokiem pojedynczej zakładki i mozliwoscia dodania jej u siebie / odtworzenia / czytania itd
    // --------------------------------------------
    // otworzenie apki na autorze
    // otworzenie apki na ksiazce
    // otworzenie apki na udostepnionej liscie ksiazek
    try {
      final segments = uri.pathSegments;
      final nonEmptySegments = segments
          .where((element) => element.isNotEmpty)
          .toList();
      final slug = nonEmptySegments.last;

      final String stringUri = uri.toString();
      if (stringUri.contains('autor')) {
        // Navigate to author
        router.pushNamed(authorPageConfig.name, pathParameters: {'slug': slug});
      } else if (stringUri.contains('lektura')) {
        // Navigate to book
        router.pushNamed(bookPageConfig.name, pathParameters: {'slug': slug});
      }
    } catch (e, s) {
      print('Error parsing app link: $e, $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(child: widget.child!);
  }
}
