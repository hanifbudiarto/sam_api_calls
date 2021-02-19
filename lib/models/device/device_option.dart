import 'package:flutter/material.dart';
import 'package:sam_api_calls/models/device/device_option_message.dart';

class DeviceOption {
  bool notify;
  String notifyChecked;
  DeviceOptionMessage notifyMessage;

  bool alarm;
  String alarmChecked;
  DeviceOptionMessage alarmMessage;

  DeviceOption(
      {@required this.notify,
        @required this.alarm,
        this.notifyChecked = "",
        this.alarmChecked = "",
        DeviceOptionMessage notifyMessage,
        DeviceOptionMessage alarmMessage})
      : this.notifyMessage =
  notifyMessage == null ? DeviceOptionMessage() : notifyMessage,
        this.alarmMessage =
        alarmMessage == null ? DeviceOptionMessage() : alarmMessage;

  DeviceOption.fromJson(Map<String, dynamic> json) {
    notify = json["notify"];
    alarm = json["alert"];
    notifyChecked =
    json.containsKey("notify_checked") ? json["notify_checked"] : "";
    alarmChecked =
    json.containsKey("alert_checked") ? json["alert_checked"] : "";

    notifyMessage = json.containsKey("notifymsg")
        ? DeviceOptionMessage.fromJson(json["notifymsg"])
        : DeviceOptionMessage();
    alarmMessage = json.containsKey("alarmmsg")
        ? DeviceOptionMessage.fromJson(json["alarmmsg"])
        : DeviceOptionMessage();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['notify'] = this.notify;
    data['notify_checked'] = this.notifyChecked;
    data['alert'] = this.alarm;
    data['alert_checked'] = this.alarmChecked;
    data["notifymsg"] = this.notifyMessage;
    data["alarmmsg"] = this.alarmMessage;
    return data;
  }
}
