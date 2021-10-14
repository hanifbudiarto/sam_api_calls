part of sam_models_devices;

class DeviceIot {
  late final String id;
  late final String sn;
  late final String model;
  late final String name;
  String? sammy;
  String? localip;
  String? fwName;
  String? fwVersion;
  String? stats;
  String? state;
  String? desc;
  String? mapLng;
  String? mapLat;
  String? logo;
  late final List<Node> nodes;
  String? born;
  String? adminId;
  String? developerId;
  bool? isLogged;
  bool? serverTime;
  bool? status;
  bool? reset;
  bool? restart;
  String? mac;
  DeviceOption? options;
  Wgt? wgt;

  DeviceIot({required this.id,
    required this.sn,
    required this.model,
    required this.name,
    this.sammy,
    this.localip,
    this.fwName,
    this.fwVersion,
    this.stats,
    this.state,
    this.desc,
    this.mapLng,
    this.mapLat,
    this.logo,
    required this.nodes,
    this.born,
    this.adminId,
    this.developerId,
    this.isLogged,
    this.serverTime,
    this.status,
    this.reset,
    this.restart,
    this.mac,
    this.options,
    this.wgt});

  DeviceIot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sn = json['sn'];
    model = json['model'];
    name = json['name'];
    sammy = json['sammy'];
    localip = json['localip'];
    fwName = json['fw_name'];
    fwVersion = json['fw_version'];
    stats = json['stats'];
    state = (json.containsKey('state')) ? json['state'] : 'lost';
    desc = json['desc'];
    mapLng = json['map_lng'];
    mapLat = json['map_lat'];
    logo = json['logo'];
    nodes = [];
    if (json['nodes'].toString() != 'null') {
      json['nodes'].forEach((v) {
        nodes.add(new Node.fromJson(v));
      });
    }

    born = json['born'];
    adminId = json['admin_id'];
    developerId = json['developer_id'];
    isLogged = json['is_logged'];
    serverTime = json['server_time'];
    status = json['status'];
    reset = json.containsKey('reset') ? json['reset'] : false;
    restart = json.containsKey('restart') ? json['restart'] : false;
    mac = json['mac'] == 'null' ? '-' : json['mac'];
    options = json['options'].toString() == 'null'
        ? null
        : DeviceOption.fromJson(json['options']);
    wgt = json['widget'].toString() == 'null'
        ? null
        : Wgt.fromJson(json['widget']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sn'] = this.sn;
    data['model'] = this.model;
    data['name'] = this.name;
    data['sammy'] = this.sammy;
    data['localip'] = this.localip;
    data['fw_name'] = this.fwName;
    data['fw_version'] = this.fwVersion;
    data['stats'] = this.stats;
    data['state'] = this.state;
    data['desc'] = this.desc;
    data['map_lng'] = this.mapLng;
    data['map_lat'] = this.mapLat;
    data['logo'] = this.logo;
    data['nodes'] = this.nodes.map((v) => v.toJson()).toList();
    data['born'] = this.born;
    data['admin_id'] = this.adminId;
    data['developer_id'] = this.developerId;
    data['is_logged'] = this.isLogged;
    data['server_time'] = this.serverTime;
    data['status'] = this.status;
    data['reset'] = this.reset;
    data['restart'] = this.restart;
    data['mac'] = this.mac;

    if (this.options != null) {
      data['options'] = this.options!.toJson();
    } else
      data['options'] = null;

    if (this.wgt != null) {
      data['widget'] = this.wgt!.toJson();
    } else
      data['widget'] = null;

    return data;
  }

  @override
  bool operator ==(other) {
    return (other is DeviceIot) && other.id == id;
  }

  int get hashCode => id.hashCode;
}
