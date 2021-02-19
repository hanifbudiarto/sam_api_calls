// from endpoint /share not /devicesshared

import 'package:sam_api_calls/models/shared/shared_device.dart';

class SharedDevices {
  /*
  "type": "ok",
  "title": "Success",
  "desc": "Request processed successfully..!",
  "request": "share",
  "totalrecords": "3",
  "body": [{}] 
  */
  final List<SharedDevice> list;

  SharedDevices({this.list});

  factory SharedDevices.fromJson(Map<String, dynamic> json) {
    List<SharedDevice> list = [];
    if (json.containsKey("body")) {
      var results = json["body"] as List;
      list.addAll(results.map((d) => SharedDevice.fromJson(d)).toList());
    }
    return SharedDevices(list: list);
  }
}