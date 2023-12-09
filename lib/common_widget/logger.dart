import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerUtils {
  static var logger = Logger(
      printer: PrettyPrinter(
    printEmojis: true,
    printTime: false,
    colors: true,
  ));

  static void logE(String title) {
    if (kDebugMode) {
      logger.e(title);
    }
  }

  static void logException(
    String title,
  ) {
    if (kDebugMode) {
      logger.e('#### Exception : $title');
    }
  }

  static void logI(
    String title,
  ) {
    if (kDebugMode) {
      logger.i(title);
    }
  }
}
