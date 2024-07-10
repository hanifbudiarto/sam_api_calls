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

  final String id;
  final String vcode;
  final DeviceIot sharedItem;
  final UserAccount sharedFrom;

  SharedDevice(
      {required this.id,
      this.vcode = "",
      required this.sharedItem,
      required this.sharedFrom});

  SharedDevice.fromJson(Map<String, dynamic> json)
      : this.id = json['id'].toString(),
        this.vcode = ifNullReturnEmpty(json['vcode']),
        this.sharedItem = DeviceIot.fromJson(json['share_item']),
        this.sharedFrom = UserAccount.fromJson(json['share_from']);
}
