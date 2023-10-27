import 'package:logger/logger.dart';

class LogHelper {
  static Logger logger = Logger(printer: PrettyPrinter(), filter: null);

  static void logInfo(message) {
    logger.i(message);
  }

  static void logError(message, {StackTrace? stack}) {
    logger.e(message, null, stack);
  }
}
