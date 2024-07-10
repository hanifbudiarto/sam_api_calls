part of sam_models_devices;

enum LogsStyle { Ohlc, Avg }

extension LogsStyleExtension on LogsStyle {
  String get name {
    switch (this) {
      case LogsStyle.Ohlc:
        return 'ohlc';
      case LogsStyle.Avg:
        return 'avg';
      default:
        return '';
    }
  }
}
