part of sam_models_logs;

class Ohlc {
  late final DateTime datein;
  late final double open;
  late final double high;
  late final double low;
  late final double close;

  Ohlc(
      {required DateTime datein,
      required this.open,
      required this.high,
      required this.low,
      required this.close})
      : this.datein = datein.toLocal();

  Ohlc.fromJson(Map<String, dynamic> json) {
    DateFormat formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');

    this.datein = formatter.parse(json['datein'].toString(), true);
    this.open = double.parse(json['open']);
    this.high = double.parse(json['high']);
    this.low = double.parse(json['low']);
    this.close = double.parse(json['close']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datein'] = this.datein.toString();
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    return data;
  }
}
