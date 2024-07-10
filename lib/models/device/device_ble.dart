import 'package:sam_api_calls/util/util.dart';

class DeviceBle {
  final String id, name, address;

  DeviceBle({required this.id, this.name = "", this.address = ""});

  DeviceBle.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = ifNullReturnEmpty(json['name']),
        address = ifNullReturnEmpty(json['address']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'address': address};
}
