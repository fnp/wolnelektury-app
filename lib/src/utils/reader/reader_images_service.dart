import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';

class ReaderImagesService {
  static const String _tag = 'ReaderImagesService';
  static const String _imagesDirName = 'reader_images';
  static const String _coversDirName = 'book_covers';

  // ---------------------------------------------------------------------------
  // Book cover
  // ---------------------------------------------------------------------------

  /// Downloads the cover image for [book] to `{appDocDir}/book_covers/` and
  /// returns the local file path, or `null` if the cover is already local /
  /// missing / download fails.
  static Future<String?> downloadBookCover(BookModel book) async {
    final coverUrl = book.coverUrl;
    if (coverUrl == null || coverUrl.isEmpty || !coverUrl.startsWith('http')) {
      return null;
    }
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final coversDir = Directory('${appDocDir.path}/$_coversDirName');
      await coversDir.create(recursive: true);
      final localPath = '${coversDir.path}/${book.slug}.jpg';
      final dio = Dio();
      await dio.download(coverUrl, localPath);
      dio.close();
      return localPath;
    } catch (e) {
      AppLogger.instance.e(
        _tag,
        'Failed to download cover for ${book.slug}: $e',
      );
      return null;
    }
  }

  /// Deletes the locally stored cover for [slug].
  static Future<void> deleteBookCover(String slug) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final file = File('${appDocDir.path}/$_coversDirName/$slug.jpg');
      if (await file.exists()) await file.delete();
    } catch (e) {
      AppLogger.instance.e(_tag, 'Failed to delete cover for $slug: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Reader inline images
  // ---------------------------------------------------------------------------

  /// Collects every unique image URL from the content tree.
  static List<String> extractImageUrls(ReaderBookModelContent root) {
    final urls = <String>{};
    _collectUrls(root, urls);
    return urls.toList();
  }

  /// Downloads [urls] to `{appDocDir}/reader_images/[slug]/` using Dio.
  ///
  /// Returns a map of `{originalUrl: localFilePath}`.
  /// Images that fail to download are omitted from the map (original URL is
  /// kept in the model so the image is simply absent in offline mode).
  static Future<Map<String, String>> downloadImages(
    List<String> urls,
    String slug,
  ) async {
    if (urls.isEmpty) return {};

    final appDocDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${appDocDir.path}/$_imagesDirName/$slug');
    await imagesDir.create(recursive: true);

    final urlToLocalPath = <String, String>{};
    final dio = Dio();

    for (int i = 0; i < urls.length; i++) {
      final url = urls[i];
      try {
        final filename = _filenameFromUrl(url, i);
        final localPath = '${imagesDir.path}/$filename';
        await dio.download(url, localPath);
        urlToLocalPath[url] = localPath;
      } catch (e) {
        AppLogger.instance.e(_tag, 'Failed to download image[$i]: $url → $e');
      }
    }

    dio.close();
    return urlToLocalPath;
  }

  /// Returns a copy of [model] with every `img` src replaced by its local path
  /// according to [urlToLocalPath]. Entries missing from the map are unchanged.
  static ReaderBookModel rebuildModelWithLocalPaths(
    ReaderBookModel model,
    Map<String, String> urlToLocalPath,
  ) {
    if (urlToLocalPath.isEmpty) return model;

    return ReaderBookModel(
      masterContent: _rebuildNode(model.masterContent, urlToLocalPath),
      headerLeft: model.headerLeft != null
          ? _rebuildNode(model.headerLeft!, urlToLocalPath)
          : null,
      headerRight: model.headerRight != null
          ? _rebuildNode(model.headerRight!, urlToLocalPath)
          : null,
    );
  }

  /// Deletes the images directory for [slug].
  static Future<void> deleteImages(String slug) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDocDir.path}/$_imagesDirName/$slug');
      if (await imagesDir.exists()) {
        await imagesDir.delete(recursive: true);
      }
    } catch (e) {
      AppLogger.instance.e(_tag, 'Failed to delete images for $slug: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  static void _collectUrls(ReaderBookModelContent node, Set<String> urls) {
    if (node.tag == ReaderBookTag.img) {
      final src = node.attr?['src'] as String?;
      if (src != null && src.isNotEmpty) {
        urls.add(src);
      }
    }
    for (final child in node.contents) {
      if (child is ReaderBookModelContent) {
        _collectUrls(child, urls);
      }
    }
  }

  static ReaderBookModelContent _rebuildNode(
    ReaderBookModelContent node,
    Map<String, String> urlToLocalPath,
  ) {
    if (node.tag == ReaderBookTag.img) {
      final src = node.attr?['src'] as String?;
      final localPath = src != null ? urlToLocalPath[src] : null;
      if (localPath != null) {
        return ReaderBookModelContent(
          tag: node.tag,
          id: node.id,
          attr: {...?node.attr, 'src': localPath},
          contents: node.contents,
          paragraphIndex: node.paragraphIndex,
          visibleNumber: node.visibleNumber,
        );
      }
    }

    final updatedContents = node.contents.map((child) {
      if (child is ReaderBookModelContent) {
        return _rebuildNode(child, urlToLocalPath);
      }
      return child;
    }).toList();

    return ReaderBookModelContent(
      tag: node.tag,
      id: node.id,
      attr: node.attr,
      contents: updatedContents,
      paragraphIndex: node.paragraphIndex,
      visibleNumber: node.visibleNumber,
    );
  }

  static String _filenameFromUrl(String url, int index) {
    try {
      final uri = Uri.parse(url);
      final lastSegment = uri.pathSegments.lastWhere(
        (s) => s.isNotEmpty,
        orElse: () => '',
      );
      if (lastSegment.isNotEmpty) {
        return '${index}_$lastSegment';
      }
    } catch (_) {}
    return 'image_$index';
  }
}
