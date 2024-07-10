part of sam_models_devices;

class DeviceOption {
  final bool notify;
  final String notifyChecked;
  final DeviceOptionMessage notifyMessage;

  final bool alarm;
  final String alarmChecked;
  final DeviceOptionMessage alarmMessage;
  final DeviceBleConfig deviceBleConfig;

  const DeviceOption(
      {this.notify = false,
      this.alarm = false,
      this.notifyChecked = '',
      this.alarmChecked = '',
      this.deviceBleConfig = const DeviceBleConfig(),
      this.notifyMessage = const DeviceOptionMessage(),
      this.alarmMessage = const DeviceOptionMessage()});

  DeviceOption.fromJson(Map<String, dynamic> json)
      : notify = json['notify'] == true,
        alarm = json['alert'] == true,
        notifyChecked = json.containsKey('notify_checked')
            ? ifNullReturnEmpty(json['notify_checked'])
            : '',
        alarmChecked = json.containsKey('alert_checked')
            ? ifNullReturnEmpty(json['alert_checked'])
            : '',
        notifyMessage = json.containsKey('notifymsg') && json['notifymsg'] != null
            ? DeviceOptionMessage.fromJson(json['notifymsg'])
            : DeviceOptionMessage(),
        alarmMessage = json.containsKey('alarmmsg') && json['alarmmsg'] != null
            ? DeviceOptionMessage.fromJson(json['alarmmsg'])
            : DeviceOptionMessage(),
        deviceBleConfig = getBleConfig(json);

  static DeviceBleConfig getBleConfig(Map<String, dynamic> json) {
    if (json.containsKey("ble") &&
        json['ble'].runtimeType != Null &&
        json['ble'] != null &&
        json['ble'].toString() != 'null') {
      return DeviceBleConfig.fromJson(json["ble"]);
    }

    return DeviceBleConfig();
  }

  Map<String, dynamic> toJson() => {
        'notify': this.notify,
        'notify_checked': this.notifyChecked,
        'alert': this.alarm,
        'alert_checked': this.alarmChecked,
        'notifymsg': this.notifyMessage.toJson(),
        'alarmmsg': this.alarmMessage.toJson(),
        'ble': this.deviceBleConfig.toJson()
      };
}
