part of sam_models_devices;

class DevicesLogsParam {
  final String deviceId;
  final String deviceParameter;
  final DeviceIot device;
  final int limit;

  DevicesLogsParam(
      {required this.deviceId,
      required this.deviceParameter,
      required this.device,
      required this.limit});
}
