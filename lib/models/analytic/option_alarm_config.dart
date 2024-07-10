import 'package:sam_api_calls/models/analytic/option_alarm_day.dart';

class OptionAlarmConfig {
  final OptionAlarmDay sunday;
  final OptionAlarmDay monday;
  final OptionAlarmDay tuesday;
  final OptionAlarmDay wednesday;
  final OptionAlarmDay thursday;
  final OptionAlarmDay friday;
  final OptionAlarmDay saturday;
  final OptionAlarmDay custom;

  const OptionAlarmConfig(
      {this.sunday = const OptionAlarmDay(),
      this.monday = const OptionAlarmDay(),
      this.tuesday = const OptionAlarmDay(),
      this.wednesday = const OptionAlarmDay(),
      this.thursday = const OptionAlarmDay(),
      this.friday = const OptionAlarmDay(),
      this.saturday = const OptionAlarmDay(),
      this.custom = const OptionAlarmDay()});

  OptionAlarmConfig.fromJson(Map<String, dynamic> json)
      : sunday = OptionAlarmDay.fromJson(json['sunday']),
        monday = OptionAlarmDay.fromJson(json['monday']),
        tuesday = OptionAlarmDay.fromJson(json['tuesday']),
        wednesday = OptionAlarmDay.fromJson(json['wednesday']),
        thursday = OptionAlarmDay.fromJson(json['thursday']),
        friday = OptionAlarmDay.fromJson(json['friday']),
        saturday = OptionAlarmDay.fromJson(json['saturday']),
        custom = OptionAlarmDay.fromJson(json['custom']);

  Map<String, dynamic> toJson() => {
        'sunday': this.sunday.toJson(),
        'monday': this.monday.toJson(),
        'tuesday': this.tuesday.toJson(),
        'wednesday': this.wednesday.toJson(),
        'thursday': this.thursday.toJson(),
        'friday': this.friday.toJson(),
        'saturday': this.saturday.toJson(),
        'custom': this.custom.toJson(),
      };
}
