part of sam_models_devices;

class DeviceClaimParam {
  final String userId;
  final String id;
  final String sn;
  final String model;
  final String name;
  final String? desc;
  final String? mapLng;
  final String? mapLat;
  final String? logo;
  final bool? status;

  DeviceClaimParam(
      {required this.userId,
      required this.id,
      required this.sn,
      required this.model,
      required this.name,
      this.desc,
      this.mapLng,
      this.mapLat,
      this.logo,
      this.status});
}
