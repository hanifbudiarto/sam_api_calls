part of sam_models_devices;

class Node {
  late final String id;
  late final String name;
  late final List<Property> properties;
  String? array;
  bool? isConfig;

  Node(
      {required this.id,
      required this.name,
      required this.properties,
      this.array,
      this.isConfig});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    properties = <Property>[];
    if (json['properties'].toString() != 'null') {
      json['properties'].forEach((v) {
        properties.add(new Property.fromJson(id, v));
      });
    }
    array = json['array'];
    isConfig = json.containsKey('isconfig') ? json['isconfig'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['properties'] = this.properties.map((v) => v.toJson()).toList();
    data['array'] = this.array;
    data['isconfig'] = this.isConfig;
    return data;
  }
}
