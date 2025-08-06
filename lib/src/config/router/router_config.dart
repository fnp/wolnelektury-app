class _RouteConfig {
  final String path;
  final String name;

  const _RouteConfig({required this.path, required this.name});
}

const cataloguePageConfig = _RouteConfig(
  name: 'cataloguePage',
  path: '/cataloguePage',
);

const lastReadPageConfig = _RouteConfig(
  name: 'bookmarkPage',
  path: '/bookmarkPage',
);

const myLibraryPageConfig = _RouteConfig(
  name: 'myLibraryPage',
  path: '/myLibraryPage',
);

const settingsPageConfig = _RouteConfig(
  name: 'settingsPage',
  path: '/settingsPage',
);

const bookPageConfig = _RouteConfig(name: 'bookPage', path: '/bookPage/:slug');

const authorPageConfig = _RouteConfig(
  name: 'authorPage',
  path: '/authorPage/:slug',
);

const readingPageConfig = _RouteConfig(
  name: 'readingPage',
  path: '/readingPage/:slug',
);

const readingPageConfigWithAnchor = _RouteConfig(
  name: 'readingPageWithAnchor',
  path: '/readingPage/:slug/:anchor',
);

const searchPageConfig = _RouteConfig(name: 'searchPage', path: '/searchPage');

const notFoundPageConfig = _RouteConfig(name: 'notFound', path: '/notFound');
