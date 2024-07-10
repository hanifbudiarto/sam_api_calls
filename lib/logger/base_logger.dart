part of sam_loggers;

abstract class BaseLogger {
  final Map<String, int> levels = {
    'fatal': 0,
    'error': 1,
    'info': 2,
    'debug': 3
  };

  String logLevel;
  Map<String, Map<String, dynamic>> tagMetadata =
      Map<String, Map<String, dynamic>>();

  BaseLogger({required this.logLevel});

  bool isLogLevelConditionMeet(String level) {
    if (levels.containsKey(logLevel) && levels.containsKey(level)) {
      int minimumLogLevel = levels[logLevel]!;
      int currentLogLevel = levels[level]!;
      return (minimumLogLevel >= currentLogLevel);
    }
    return false;
  }

  Map<String, dynamic>? getCombinedMetadata(String tag, Map<String, dynamic>? meta) {
    if (tagMetadata[tag] != null) {
      if (meta == null) {
        meta = new Map();
      }
      meta.addAll(tagMetadata[tag]!);
    }

    return meta;
  }

  void debug(String tag, String message, [Map<String, dynamic>? meta]) {
    if (isLogLevelConditionMeet('debug')) {
      _log('debug', message, getCombinedMetadata(tag, meta));
    }
  }

  void info(String tag, String message, [Map<String, dynamic>? meta]) {
    if (isLogLevelConditionMeet('info')) {
      _log('info', message, getCombinedMetadata(tag, meta));
    }
  }

  void error(String tag, String message, [Map<String, dynamic>? meta]) {
    if (isLogLevelConditionMeet('error')) {
      _log('error', message, getCombinedMetadata(tag, meta));
    }
  }

  void fatal(String tag, String message, [Map<String, dynamic>? meta]) {
    if (isLogLevelConditionMeet('fatal')) {
      _log('fatal', message, getCombinedMetadata(tag, meta));
    }
  }

  void _log(String level, String message, Map<String, dynamic>? meta) {
    String timestamp = DateTime.now().toString();
    String logMessage = "[$timestamp] ${level.toUpperCase()}: $message";
    if (meta != null) {
      logMessage += " ${json.encode(meta)}";
    }
    log(logMessage);
  }

  void setTagMetadata(
      {required String tag, required Map<String, dynamic> metadata}) {
    tagMetadata[tag] = metadata;
  }
}
