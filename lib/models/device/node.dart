part of sam_models_devices;

class Node {
  final String id;
  final String name;
  final List<Property> properties;
  final String array;
  final bool isConfig;

  Node(
      {required this.id,
      required this.name,
      this.properties = const <Property>[],
      this.array = "",
      this.isConfig = false});

  Node.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = ifNullReturnEmpty(json['name']),
        properties = getProperties(json),
        array = ifNullReturnEmpty(json['array']),
        isConfig = json.containsKey('isconfig') ? json['isconfig'] == true : false;

  static List<Property> getProperties(Map<String, dynamic> json) {
    List<Property> properties = <Property>[];
    if (json['properties'].runtimeType != Null ||
        json['properties'].toString() != 'null') {
      json['properties'].forEach((v) {
        properties.add(new Property.fromJson(json['id'].toString(), v));
      });
    }

    return properties;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'properties': this.properties.map((v) => v.toJson()).toList(),
        'array': this.array,
        'isconfig': this.isConfig
      };
}
