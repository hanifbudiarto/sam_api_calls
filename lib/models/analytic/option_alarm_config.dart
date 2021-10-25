import 'package:sam_api_calls/models/analytic/option_alarm_day.dart';

class OptionAlarmConfig {
  late OptionAlarmDay sunday;
  late OptionAlarmDay monday;
  late OptionAlarmDay tuesday;
  late OptionAlarmDay wednesday;
  late OptionAlarmDay thursday;
  late OptionAlarmDay friday;
  late OptionAlarmDay saturday;
  late OptionAlarmDay custom;

  OptionAlarmConfig(
      {OptionAlarmDay? sunday,
      OptionAlarmDay? monday,
      OptionAlarmDay? tuesday,
      OptionAlarmDay? wednesday,
      OptionAlarmDay? thursday,
      OptionAlarmDay? friday,
      OptionAlarmDay? saturday,
      OptionAlarmDay? custom})
      : this.sunday = sunday == null ? OptionAlarmDay() : sunday,
        this.monday = monday == null ? OptionAlarmDay() : monday,
        this.tuesday = tuesday == null ? OptionAlarmDay() : tuesday,
        this.wednesday = wednesday == null ? OptionAlarmDay() : wednesday,
        this.thursday = thursday == null ? OptionAlarmDay() : thursday,
        this.friday = friday == null ? OptionAlarmDay() : friday,
        this.saturday = saturday == null ? OptionAlarmDay() : saturday,
        this.custom = custom == null ? OptionAlarmDay() : custom;

  OptionAlarmConfig.fromJson(Map<String, dynamic> json) {
    sunday = OptionAlarmDay.fromJson(json['sunday']);
    monday = OptionAlarmDay.fromJson(json['monday']);
    tuesday = OptionAlarmDay.fromJson(json['tuesday']);
    wednesday = OptionAlarmDay.fromJson(json['wednesday']);
    thursday = OptionAlarmDay.fromJson(json['thursday']);
    friday = OptionAlarmDay.fromJson(json['friday']);
    saturday = OptionAlarmDay.fromJson(json['saturday']);
    custom = OptionAlarmDay.fromJson(json['custom']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sunday'] = this.sunday.toJson();
    data['monday'] = this.monday.toJson();
    data['tuesday'] = this.tuesday.toJson();
    data['wednesday'] = this.wednesday.toJson();
    data['thursday'] = this.thursday.toJson();
    data['friday'] = this.friday.toJson();
    data['saturday'] = this.saturday.toJson();
    data['custom'] = this.custom.toJson();
    return data;
  }
}
