part of sam_models_shared;

class SharedDevice {
  /*
  'id': '99',
  'vcode': 'D044E8',
  'usefor': 'sharedevice',
  'issued_date': '2018-08-29 04:36:13',
  'expire_date': '2018-09-01 04:36:13',
  'used_date': null,
  'share_id': '6',
  'share_by': '97'
   */

  late final String id;
  late final String vcode;
  late final DeviceIot sharedItem;
  late final UserAccount sharedFrom;

  SharedDevice(
      {required this.id,
      required this.vcode,
      required this.sharedItem,
      required this.sharedFrom});

  SharedDevice.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.vcode = json['vcode'];
    this.sharedItem = DeviceIot.fromJson(json['share_item']);
    this.sharedFrom = UserAccount.fromJson(json['share_from']);
  }
}
