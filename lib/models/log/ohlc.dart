part of sam_models_logs;

class Ohlc {
  final DateTime datein;
  final double open;
  final double high;
  final double low;
  final double close;

  static final DateFormat formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');

  Ohlc({required DateTime datein,
    required this.open,
    required this.high,
    required this.low,
    required this.close})
      : this.datein = datein.toLocal();

  Ohlc.fromJson(Map<String, dynamic> json)
      : this.datein = formatter.parse(json['datein'].toString(), true),
        this.open = double.parse(ifNullReturnEmpty(json['open'])),
        this.high = double.parse(ifNullReturnEmpty(json['high'])),
        this.low = double.parse(ifNullReturnEmpty(json['low'])),
        this.close = double.parse(ifNullReturnEmpty(json['close']));

  Map<String, dynamic> toJson() =>
      {
        'datein': this.datein.toString(),
        'open': this.open,
        'high': this.high,
        'low': this.low,
        'close': this.close,
      };
}
