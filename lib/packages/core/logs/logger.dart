import 'package:logger/logger.dart' as lgr;

/// A cross features logger that logs messages to the console
/// based on their type
final class AppLogger {
  const AppLogger._();

  static final lgr.Logger _logger = lgr.Logger();

  /// Log debug messages
  static debug(String message) {
    _logger.d(message);
  }

  /// Log error messages
  static error(String message) {
    _logger.e(message);
  }

  /// Log info messages
  static info(String message) {
    _logger.i(message);
  }

  /// Log warning messages
  static warning(String message) {
    _logger.w(message);
  }
}
