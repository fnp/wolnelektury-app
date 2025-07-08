import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/pages/account_page.dart';
import 'package:wolnelektury/src/presentation/pages/author_page.dart';
import 'package:wolnelektury/src/presentation/pages/book_page.dart';
import 'package:wolnelektury/src/presentation/pages/catalogue_page.dart';
import 'package:wolnelektury/src/presentation/pages/dashboard/dashboard_wrapper.dart';
import 'package:wolnelektury/src/presentation/pages/last_read_page.dart';
import 'package:wolnelektury/src/presentation/pages/not_found_page.dart';
import 'package:wolnelektury/src/presentation/pages/reading_page.dart';
import 'package:wolnelektury/src/presentation/pages/settings_page.dart';

extension GoRouterX on GoRouter {
  String get location =>
      routerDelegate.currentConfiguration.last.matchedLocation;

  void clearStackAndNavigateNamed(String name) {
    while (canPop()) {
      pop();
    }
    pushReplacementNamed(name);
  }
}

final routerNavigationKey = GlobalKey<NavigatorState>();
final dashboardNavigationKey = GlobalKey<NavigatorState>();

/// Main routes order
final mainPathsOrder = [
  cataloguePageConfig.path,
  lastReadPageConfig.path,
  accountPageConfig.path,
];

final GoRouter router = GoRouter(
  navigatorKey: routerNavigationKey,
  initialLocation: cataloguePageConfig.path,
  routes: [
    ShellRoute(
      navigatorKey: dashboardNavigationKey,
      builder: (context, state, child) => DashboardWrapper(child: child),
      routes: [
        GoRoute(
          path: cataloguePageConfig.path,
          name: cataloguePageConfig.name,
          pageBuilder: (context, state) {
            final RouterCubit routerCubit = context.read<RouterCubit>();
            final reversed = _isReversedTransition(routerCubit);

            return _slideTransition(
              context: context,
              state: state,
              child: const CataloguePage(),
              reversed: reversed,
            );
          },
        ),
        GoRoute(
          path: lastReadPageConfig.path,
          name: lastReadPageConfig.name,
          pageBuilder: (context, state) {
            final RouterCubit routerCubit = context.read<RouterCubit>();
            final reversed = _isReversedTransition(routerCubit);

            return _slideTransition(
              context: context,
              state: state,
              child: const LastReadPage(),
              reversed: reversed,
            );
          },
        ),
        GoRoute(
          path: accountPageConfig.path,
          name: accountPageConfig.name,
          pageBuilder: (context, state) {
            final RouterCubit routerCubit = context.read<RouterCubit>();
            final reversed = _isReversedTransition(routerCubit);

            return _slideTransition(
              context: context,
              state: state,
              child: const AccountPage(),
              reversed: reversed,
            );
          },
        ),
        GoRoute(
          path: settingsPageConfig.path,
          name: settingsPageConfig.name,
          pageBuilder: (context, state) {
            return _slideTransition(
              context: context,
              state: state,
              child: const SettingsPage(),
            );
          },
        ),
        GoRoute(
          path: bookPageConfig.path,
          name: bookPageConfig.name,
          pageBuilder: (context, state) {
            final book = state.extra as BookModel?;
            return _slideTransition(
              context: context,
              state: state,
              reversed: true,
              child: BookPage(book: book),
            );
          },
        ),
        GoRoute(
          path: authorPageConfig.path,
          name: authorPageConfig.name,
          pageBuilder: (context, state) {
            final authorSlug = state.pathParameters['slug'];
            return _slideTransition(
              context: context,
              state: state,
              reversed: true,
              child: AuthorPage(authorSlug: authorSlug),
            );
          },
        ),
        GoRoute(
          path: readingPageConfigWithAnchor.path,
          name: readingPageConfigWithAnchor.name,
          pageBuilder: (context, state) {
            final book = state.extra as BookModel?;
            final anchor = int.tryParse(state.pathParameters['anchor'] ?? '');
            final slug = state.pathParameters['slug'];
            return _slideTransition(
              context: context,
              state: state,
              reversed: true,
              child: ReadingPage(
                book: book,
                overrideProgressAnchor: anchor,
                slug: slug,
              ),
            );
          },
        ),
        GoRoute(
          path: readingPageConfig.path,
          name: readingPageConfig.name,
          pageBuilder: (context, state) {
            final book = state.extra as BookModel?;
            final slug = state.pathParameters['slug'];
            return _slideTransition(
              context: context,
              state: state,
              reversed: true,
              child: ReadingPage(book: book, slug: slug),
            );
          },
        ),
        GoRoute(
          path: notFoundPageConfig.path,
          name: notFoundPageConfig.name,
          pageBuilder: (context, state) {
            return _slideTransition(
              context: context,
              state: state,
              child: const NotFoundPage(),
            );
          },
        ),
      ],
    ),
  ],
);

/// Checks if the transition is reversed
bool _isReversedTransition(RouterCubit routerCubit) {
  final currentIndex = mainPathsOrder.indexOf(routerCubit.state.location);
  final previousIndex = mainPathsOrder.indexOf(
    routerCubit.state.previousLocation,
  );
  return currentIndex > previousIndex;
}

/// Creates animation between two pages
CustomTransitionPage _slideTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool reversed = false,
  LocalKey? transitionKey,
}) {
  return CustomTransitionPage(
    key: transitionKey ?? state.pageKey,
    barrierColor: Theme.of(context).scaffoldBackgroundColor,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondAnimation, child) {
      final begin = reversed ? const Offset(0.5, 0.0) : const Offset(-0.5, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final slideAnim = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(slideAnim),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    child: child,
  );
}
