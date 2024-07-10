part of sam_loggers;

class LokiLogger extends BaseLogger {
  final String username, password, server;
  final Map<String, String> labels;

  final Dio dio = Dio();

  LokiLogger(
      {required this.server,
      required this.username,
      required this.password,
      required String logLevel,
      required this.labels})
      : super(logLevel: logLevel) {
    dio.httpClientAdapter = IOHttpClientAdapter(onHttpClientCreate: (client) {
      // Don't trust any certificate just because their root cert is trusted.
      final HttpClient client =
          HttpClient(context: SecurityContext(withTrustedRoots: false));
      // You can test the intermediate / root cert here. We just ignore it.
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    });
  }

  @override
  void debug(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.debug(tag, message, meta);
    _send('debug', tag, message, meta);
  }

  @override
  void info(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.info(tag, message, meta);
    _send('info', tag, message, meta);
  }

  @override
  void error(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.error(tag, message, meta);
    _send('error', tag, message, meta);
  }

  @override
  void fatal(String tag, String message, [Map<String, dynamic>? meta = null]) {
    super.fatal(tag, message, meta);
    _send('fatal', tag, message, meta);
  }

  void _send(String level, String tag, String message,
      [Map<String, dynamic>? meta]) {
    try {
      if (isLogLevelConditionMeet(level)) {
        final DateTime now = DateTime.now();

        Map<String, dynamic> finalMessage = {
          ...getCombinedMetadata(tag, {
            'tag': tag,
            'level': level,
            'message': message,
            'timestamp': now.toString()
          })!,
          if (meta != null) ...meta
        };

        log(json.encode(finalMessage));

        String userToken =
            "Basic " + base64Encode(utf8.encode("$username:$password"));

        var value = json.encode(LokiPushBody([
          LokiStream(labels, [
            LokiValue((now.microsecondsSinceEpoch * 1000).toString(),
                json.encode(finalMessage))
          ])
        ]).toJson());

        dio
            .post(server,
                options: Options(headers: <String, String>{
                  HttpHeaders.authorizationHeader: userToken,
                  HttpHeaders.contentTypeHeader: 'application/json',
                }),
                data: value)
            .timeout(const Duration(seconds: 5, milliseconds: 750))
            .catchError((e) {
          log(e.toString());
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

class LokiPushBody {
  LokiPushBody(this.streams);

  final List<LokiStream> streams;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'streams':
            streams.map((stream) => stream.toJson()).toList(growable: false),
      };
}

class LokiStream {
  LokiStream(this.labels, this.values);

  final Map<String, String> labels;
  final List<LokiValue> values;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'stream': labels,
        'values': values.map((value) => [value.epoch, value.message]).toList()
      };
}

class LokiValue {
  LokiValue(this.epoch, this.message);

  final String epoch;
  final String message;
}
