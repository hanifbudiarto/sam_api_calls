part of sam_models_devices;

class DeviceOption {
  late bool notify;
  late String notifyChecked;
  late final DeviceOptionMessage notifyMessage;

  late bool alarm;
  late String alarmChecked;
  late final DeviceOptionMessage alarmMessage;

  DeviceOption(
      {this.notify = false,
      this.alarm = false,
      this.notifyChecked = '',
      this.alarmChecked = '',
      required this.notifyMessage,
      required this.alarmMessage});

  DeviceOption.fromJson(Map<String, dynamic> json) {
    notify = json['notify'];
    alarm = json['alert'];
    notifyChecked =
        json.containsKey('notify_checked') ? json['notify_checked'] : '';
    alarmChecked =
        json.containsKey('alert_checked') ? json['alert_checked'] : '';

    notifyMessage = json.containsKey('notifymsg')
        ? DeviceOptionMessage.fromJson(json['notifymsg'])
        : DeviceOptionMessage();
    alarmMessage = json.containsKey('alarmmsg')
        ? DeviceOptionMessage.fromJson(json['alarmmsg'])
        : DeviceOptionMessage();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['notify'] = this.notify;
    data['notify_checked'] = this.notifyChecked;
    data['alert'] = this.alarm;
    data['alert_checked'] = this.alarmChecked;
    data['notifymsg'] = this.notifyMessage;
    data['alarmmsg'] = this.alarmMessage;
    return data;
  }
}
