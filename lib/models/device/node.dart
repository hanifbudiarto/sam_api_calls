
import 'property.dart';

class Node {
  String id;
  String name;
  String type;
  List<Property> properties;
  String array;
  bool isConfig;

  Node(
      {this.id,
        this.name,
        this.type,
        this.properties,
        this.array,
        this.isConfig});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    if (json['properties'].toString() != "null") {
      properties = new List<Property>();
      json['properties'].forEach((v) {
        properties.add(new Property.fromJson(id, v));
      });
    } else
      json['properties'] = [];
    array = json['array'];
    isConfig = json.containsKey("isconfig") ? json['isconfig'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties.map((v) => v.toJson()).toList();
    } else
      data['properties'] = [];
    data['array'] = this.array;
    data['isconfig'] = this.isConfig;
    return data;
  }
}