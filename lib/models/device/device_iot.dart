part of sam_models_devices;

class DeviceIot {
  final String id;
  final String sn;
  final String model;
  final String name;
  final String sammy;
  final String localip;
  final String fwName;
  final String fwVersion;
  final String stats;
  final String state;
  final String desc;
  final String mapLng;
  final String mapLat;
  final String logo;
  final List<Node> nodes;
  final String born;
  final String adminId;
  final String developerId;
  final bool isLogged;
  final bool serverTime;
  final bool status;
  final bool reset;
  final bool restart;
  final String mac;
  final DeviceOption options;
  final Wgt wgt;
  final String fwUpdateMode;
  final int fwVersionCode;
  final int fwSize;

  DeviceIot(
      {required this.id,
      required this.sn,
      this.model = "",
      this.name = "",
      this.sammy = "",
      this.localip = "",
      this.fwName = "",
      this.fwVersion = "",
      this.stats = "",
      this.state = "lost",
      this.desc = "",
      this.mapLng = "",
      this.mapLat = "",
      this.logo = "",
      this.nodes = const <Node>[],
      this.born = "",
      this.adminId = "",
      this.developerId = "",
      this.isLogged = false,
      this.serverTime = false,
      this.status = false,
      this.reset = false,
      this.restart = false,
      this.mac = "",
      this.options = const DeviceOption(),
      this.wgt = const Wgt(model: null),
      this.fwUpdateMode = "auto",
      this.fwVersionCode = 0,
      this.fwSize = 0});

  DeviceIot.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        sn = ifNullReturnEmpty(json['sn']),
        model = ifNullReturnEmpty(json['model']),
        name = ifNullReturnEmpty(json['name']),
        sammy = ifNullReturnEmpty(json['sammy']),
        localip = ifNullReturnEmpty(json['localip']),
        fwName = ifNullReturnEmpty(json['fw_name']),
        fwVersion = ifNullReturnEmpty(json['fw_version']),
        stats = ifNullReturnEmpty(json['stats']),
        state = (json.containsKey('state'))
            ? ifNullReturnEmpty(json['state'])
            : 'lost',
        desc = ifNullReturnEmpty(json['desc']),
        mapLng = ifNullReturnEmpty(json['map_lng']),
        mapLat = ifNullReturnEmpty(json['map_lat']),
        logo = ifNullReturnEmpty(json['logo']),
        nodes = getNodes(json),
        born = ifNullReturnEmpty(json['born']),
        adminId = ifNullReturnEmpty(json['admin_id']),
        developerId = json['developer_id'].toString(),
        isLogged = json['is_logged'] == true,
        serverTime = json['server_time'] == true,
        status = json['status'] == true,
        reset = json.containsKey('reset') ? json['reset'] == true : false,
        restart = json.containsKey('restart') ? json['restart'] == true : false,
        mac = ifNullReturnEmpty(json['mac']),
        options = (json.containsKey('options') && json['options'] != null)
            ? DeviceOption.fromJson(json['options'])
            : const DeviceOption(),
        wgt = (json.containsKey('widget') && json['widget'] != null)
            ? Wgt.fromJson(json['widget'])
            : const Wgt(model: null),
        fwUpdateMode = (json.containsKey('fw_update_mode'))
            ? ifNullReturnEmpty(json['fw_update_mode'])
            : 'auto',
        fwSize = (json.containsKey('fw_size')) ? json['fw_size'] : 0,
        fwVersionCode =
            (json.containsKey('fw_version_code')) ? json['fw_version_code'] : 0;

  static List<Node> getNodes(Map<String, dynamic> json) {
    List<Node> nodes = [];
    if (json['nodes'].runtimeType != Null ||
        json['nodes'].toString() != 'null') {
      json['nodes'].forEach((v) {
        nodes.add(new Node.fromJson(v));
      });
    }

    return nodes;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'sn': this.sn,
        'model': this.model,
        'name': this.name,
        'sammy': this.sammy,
        'localip': this.localip,
        'fw_name': this.fwName,
        'fw_version': this.fwVersion,
        'stats': this.stats,
        'state': this.state,
        'desc': this.desc,
        'map_lng': this.mapLng,
        'map_lat': this.mapLat,
        'logo': this.logo,
        'nodes': this.nodes.map((v) => v.toJson()).toList(),
        'born': this.born,
        'admin_id': this.adminId,
        'developer_id': this.developerId,
        'is_logged': this.isLogged,
        'server_time': this.serverTime,
        'status': this.status,
        'reset': this.reset,
        'restart': this.restart,
        'mac': this.mac,
        'options': this.options.toJson(),
        'widget': this.wgt.toJson(),
        'fw_update_mode': this.fwUpdateMode,
        'fw_size': this.fwSize,
        'fw_version_code': this.fwVersionCode
      };

  @override
  bool operator ==(other) {
    return (other is DeviceIot) && other.id == id;
  }

  int get hashCode => id.hashCode;
}
