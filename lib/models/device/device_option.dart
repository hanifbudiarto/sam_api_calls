part of sam_models_devices;

class DeviceOption {
  late bool notify;
  late String notifyChecked;
  late DeviceOptionMessage notifyMessage;

  late bool alarm;
  late String alarmChecked;
  late DeviceOptionMessage alarmMessage;
  DeviceBleConfig? deviceBleConfig;

  DeviceOption(
      {this.notify = false,
      this.alarm = false,
      this.notifyChecked = '',
      this.alarmChecked = '',
      this.deviceBleConfig,
      DeviceOptionMessage? notifyMessage,
      DeviceOptionMessage? alarmMessage})
      : this.notifyMessage =
            notifyMessage == null ? DeviceOptionMessage() : notifyMessage,
        this.alarmMessage =
            alarmMessage == null ? DeviceOptionMessage() : alarmMessage;

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

    if (json.containsKey("ble")) {
      deviceBleConfig = DeviceBleConfig.fromJson(json["ble"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['notify'] = this.notify;
    data['notify_checked'] = this.notifyChecked;
    data['alert'] = this.alarm;
    data['alert_checked'] = this.alarmChecked;
    data['notifymsg'] = this.notifyMessage;
    data['alarmmsg'] = this.alarmMessage;
    data['ble'] = this.deviceBleConfig;
    return data;
  }
}
