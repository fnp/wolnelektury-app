import 'package:flutter_dotenv/flutter_dotenv.dart';

extension StringEx on String {
  String get removeApiUrl => replaceAll(dotenv.env['apiUrl'] ?? '', '');

  String get firstLetterUppercase =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
