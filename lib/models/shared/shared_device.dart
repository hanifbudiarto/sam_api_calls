import 'package:sam_api_calls/models/device/device.dart';
import 'package:sam_api_calls/models/user/user.dart';

class SharedDevice {
  /*
  "id": "99",
  "vcode": "D044E8",
  "usefor": "sharedevice",
  "issued_date": "2018-08-29 04:36:13",
  "expire_date": "2018-09-01 04:36:13",
  "used_date": null,
  "share_id": "6",
  "share_by": "97"
   */
  final String id;
  final String vcode;
  final DeviceIot sharedItem;
  final UserAccount sharedFrom;

  SharedDevice({this.id, this.vcode, this.sharedItem, this.sharedFrom});

  factory SharedDevice.fromJson(Map<String, dynamic> json) {
    return SharedDevice(
        id: json["id"].toString(),
        vcode: json["vcode"].toString(),
        sharedItem: DeviceIot.fromJson(json["share_item"]),
        sharedFrom: UserAccount.fromJson(json["share_from"]));
  }
}
