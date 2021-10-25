class OptionAlarmDay {
  late bool enabled;
  late String at;

  OptionAlarmDay({this.enabled = false, this.at = ""});

  OptionAlarmDay.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    at = json['at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['at'] = this.at;
    return data;
  }
}