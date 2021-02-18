import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ohlc {
  DateTime datein;
  double open;
  double high;
  double low;
  double close;

  Ohlc(
      {@required DateTime datein,
      @required this.open,
      @required this.high,
      @required this.low,
      @required this.close})
      : this.datein = datein.toLocal();

  factory Ohlc.fromJson(Map<String, dynamic> json) {
    DateFormat formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');

    var ohlc;
    try {
      ohlc = Ohlc(
          datein: formatter.parse(json["datein"].toString(), true),
          open: double.parse(json["open"]),
          high: double.parse(json["high"]),
          low: double.parse(json["low"]),
          close: double.parse(json["close"]));
    } catch (e) {
      print(e.toString());
    }

    return ohlc;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["datein"] = this.datein.toString();
    data["open"] = this.open;
    data["high"] = this.high;
    data["low"] = this.low;
    data["close"] = this.close;
    return data;
  }
}
