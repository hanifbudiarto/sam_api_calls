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
  late final List<SharedDevice> list;

  SharedDevices({required this.list});

  SharedDevices.fromJson(Map<String, dynamic> json) {
    List<SharedDevice> list = [];
    if (json.containsKey('body')) {
      var results = json['body'] as List;
      list.addAll(results.map((d) => SharedDevice.fromJson(d)).toList());
    }
    this.list = list;
  }
}
