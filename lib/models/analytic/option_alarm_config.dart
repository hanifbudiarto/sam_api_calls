import 'package:sam_api_calls/models/analytic/option_alarm_day.dart';

class OptionAlarmConfig {
  late OptionAlarmDay? sunday;
  late OptionAlarmDay? monday;
  late OptionAlarmDay? tuesday;
  late OptionAlarmDay? wednesday;
  late OptionAlarmDay? thursday;
  late OptionAlarmDay? friday;
  late OptionAlarmDay? saturday;
  late OptionAlarmDay? custom;

  OptionAlarmConfig(
      {required this.sunday,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.custom});

  OptionAlarmConfig.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'] != null
        ? new OptionAlarmDay.fromJson(json['sunday'])
        : null;
    monday = json['monday'] != null
        ? new OptionAlarmDay.fromJson(json['monday'])
        : null;
    tuesday = json['tuesday'] != null
        ? new OptionAlarmDay.fromJson(json['tuesday'])
        : null;
    wednesday = json['wednesday'] != null
        ? new OptionAlarmDay.fromJson(json['wednesday'])
        : null;
    thursday = json['thursday'] != null
        ? new OptionAlarmDay.fromJson(json['thursday'])
        : null;
    friday = json['friday'] != null
        ? new OptionAlarmDay.fromJson(json['friday'])
        : null;
    saturday = json['saturday'] != null
        ? new OptionAlarmDay.fromJson(json['saturday'])
        : null;
    custom = json['custom'] != null
        ? new OptionAlarmDay.fromJson(json['custom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    if (this.custom != null) {
      data['custom'] = this.custom!.toJson();
    }
    return data;
  }
}
