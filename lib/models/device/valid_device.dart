import 'package:flutter/material.dart';

import 'device_iot.dart';

class ValidDevice {
  final String id;
  final DeviceIot device;
  final bool valid;

  ValidDevice({@required this.id, @required this.device, @required this.valid});

  operator ==(validDevice) => validDevice.id == id;

  int get hashCode => id.hashCode;
}
