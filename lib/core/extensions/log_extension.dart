import 'package:flutter/foundation.dart';

/// ANSI color codes
class LogColor {
  static const reset = '\x1B[0m';

  static const black = '\x1B[30m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
  static const white = '\x1B[37m';

  static const bold = '\x1B[1m';
}

/// Extension log
extension LogExtension on Object {
  void log({
    String tag = 'LOG',
    String color = LogColor.white,
    bool bold = false,
  }) {
    if (kDebugMode) {
      final boldText = bold ? LogColor.bold : '';
      debugPrint(
        '$boldText$color[$tag] $this${LogColor.reset}',
      );
    }
  }

  /// 🔴 Error
  void logRed({String tag = 'ERROR'}) =>
      log(tag: tag, color: LogColor.red, bold: true);

  /// 🟢 Success
  void logGreen({String tag = 'SUCCESS'}) =>
      log(tag: tag, color: LogColor.green);

  /// 🟡 Warning
  void logYellow({String tag = 'WARNING'}) =>
      log(tag: tag, color: LogColor.yellow);

  /// 🔵 Info
  void logBlue({String tag = 'INFO'}) =>
      log(tag: tag, color: LogColor.blue);

  /// 🟣 Debug
  void logMagenta({String tag = 'DEBUG'}) =>
      log(tag: tag, color: LogColor.magenta);

  /// 🔹 Cyan (API / Network)
  void logCyan({String tag = 'API'}) =>
      log(tag: tag, color: LogColor.cyan);
}
