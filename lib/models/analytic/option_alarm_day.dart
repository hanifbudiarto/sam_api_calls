import 'package:sam_api_calls/util/util.dart';

class OptionAlarmDay {
  final bool enabled;
  final String at;

  const OptionAlarmDay({this.enabled = false, this.at = ""});

  OptionAlarmDay.fromJson(Map<String, dynamic> json)
      : enabled = json['enabled'] == true,
        at = ifNullReturnEmpty(json['at']);

  Map<String, dynamic> toJson() => {'enabled': this.enabled, 'at': this.at};
}
