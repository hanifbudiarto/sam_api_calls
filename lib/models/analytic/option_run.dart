import 'package:sam_api_calls/models/analytic/option_alarm_config.dart';
import 'package:sam_api_calls/util/util.dart';

class OptionRun {
  final String condition;
  final int delay;
  final OptionAlarmConfig alarm;

  const OptionRun(
      {this.condition = "", this.delay = 0, this.alarm = const OptionAlarmConfig()});

  OptionRun.fromJson(Map<String, dynamic> json)
      : condition = ifNullReturnEmpty(json['condition']),
        delay = json['delay'],
        alarm = json['alarm'].runtimeType != Null ||
                json['alarm'] != null ||
                json['alarm'].toString() != 'null'
            ? new OptionAlarmConfig.fromJson(json['alarm'])
            : new OptionAlarmConfig();

  Map<String, dynamic> toJson() => {
        'condition': this.condition,
        'delay': this.delay,
        'alarm': this.alarm.toJson(),
      };
}
