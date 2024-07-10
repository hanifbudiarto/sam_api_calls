part of sam_loggers;

class ConsoleLogger extends BaseLogger {
  String logLevel;

  ConsoleLogger({required this.logLevel}) : super(logLevel: logLevel);

  @override
  void fatal(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.fatal(tag, message, meta);
  }

  @override
  void error(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.error(tag, message, meta);
  }

  @override
  void info(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.info(tag, message, meta);
  }

  @override
  void debug(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.debug(tag, message, meta);
  }
}