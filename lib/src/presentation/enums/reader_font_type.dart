import 'package:wolnelektury/src/config/theme/theme.dart';

enum ReaderFontType { sans, serif }

extension ReaderFontTypeExtension on ReaderFontType {
  String get familyName {
    switch (this) {
      case ReaderFontType.sans:
        return sourceSans3Family;
      case ReaderFontType.serif:
        return sourceSerif4Family;
    }
  }
}

ReaderFontType readerFontTypeFromString(String value) {
  switch (value) {
    case 'sans':
      return ReaderFontType.sans;
    case 'serif':
      return ReaderFontType.serif;
    default:
      return ReaderFontType.sans;
  }
}
