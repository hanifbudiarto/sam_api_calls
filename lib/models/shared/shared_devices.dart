// from endpoint /share not /devicesshared

part of sam_models_shared;

class SharedDevices {
  /*
  'type': 'ok',
  'title': 'Success',
  'desc': 'Request processed successfully..!',
  'request': 'share',
  'totalrecords': '3',
  'body': [{}] 
  */
  final List<SharedDevice> list;

  SharedDevices({this.list = const <SharedDevice>[]});

  SharedDevices.fromJson(Map<String, dynamic> json)
      : this.list = json.containsKey('body') ? getList(json) : [];

  static List<SharedDevice> getList(Map<String, dynamic> json) {
    List<SharedDevice> list = [];
    var results = json['body'] as List;
    list.addAll(results.map((d) => SharedDevice.fromJson(d)).toList());
    return list;
  }
}
