import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static AppLogger instance = AppLogger._();

  /// Log a message at level [Level.trace].
  void t(String tag, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appLogger.t('$tag: $message, $error, $stackTrace');
  }

  /// Log a message at level [Level.debug].
  void d(String tag, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appLogger.d('$tag: $message, $error, $stackTrace');
  }

  /// Log a message at level [Level.info].
  void i(String tag, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appLogger.i('$tag: $message, $error, $stackTrace');
  }

  /// Log a message at level [Level.warning].
  void w(String tag, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appLogger.w('$tag: $message, $error, $stackTrace');
  }

  /// Log a message at level [Level.error].
  void e(String tag, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appLogger.e('$tag: $message, $error, $stackTrace');
  }

  final Logger _appLogger = Logger(
    filter: null,
    printer: SimplePrinter(),
    output: null,
    level: Level.debug,
  );
}
