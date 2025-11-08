import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';

class ShareUtils {
  static final String _shareBaseUrl = dotenv.env['shareBaseUrl'] ?? '';

  static Future<void> shareBookmark(BookmarkModel bookmark) async {
    SharePlus.instance.share(
      ShareParams(text: '$_shareBaseUrl/katalog/zakladka/${bookmark.uuid}'),
    );
  }

  static Future<void> shareAuthor(String authorSlug) async {
    SharePlus.instance.share(
      ShareParams(text: '$_shareBaseUrl/katalog/autor/$authorSlug'),
    );
  }

  static Future<void> shareBook(String bookSlug) async {
    SharePlus.instance.share(
      ShareParams(text: '$_shareBaseUrl/katalog/lektura/$bookSlug'),
    );
  }

  static Future<void> shareParagraph(int paragraphId, String bookSlug) async {
    SharePlus.instance.share(
      ShareParams(
        text: '$_shareBaseUrl/katalog/czytnik/$bookSlug/$paragraphId',
      ),
    );
  }
}
