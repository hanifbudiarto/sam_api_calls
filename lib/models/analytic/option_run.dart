import 'package:sam_api_calls/models/analytic/option_alarm_config.dart';

class OptionRun {
  late String condition;
  late int delay;
  late OptionAlarmConfig? alarm;

  OptionRun(
      {required this.condition, required this.delay, required this.alarm});

  OptionRun.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    delay = json['delay'];
    alarm = json['alarm'] != null
        ? new OptionAlarmConfig.fromJson(json['alarm'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['delay'] = this.delay;
    if (this.alarm != null) {
      data['alarm'] = this.alarm!.toJson();
    }
    return data;
  }
}
