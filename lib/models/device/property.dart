part of sam_models_devices;

class Property {
  String? parentId;
  late final String id;
  String? name;
  bool? settable;
  bool? retained;
  String? unit;
  String? datatype;
  String? format;

  Property(
      {this.parentId,
      required this.id,
      this.name,
      this.settable,
      this.retained,
      this.unit,
      this.datatype,
      this.format});

  Property.copyFrom(Property prop) {
    this.parentId = prop.parentId;
    this.id = prop.id;
    this.name = prop.name;
    this.settable = prop.settable;
    this.retained = prop.retained;
    this.unit = prop.unit;
    this.datatype = prop.datatype;
    this.format = prop.format;
  }

  Property.fromJson(String parentId, Map<String, dynamic> json) {
    this.parentId = parentId;

    id = json['id'];
    name = json['name'];
    settable = json['settable'];
    retained = json['retained'];
    unit = json['unit'];
    datatype = json['datatype'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['settable'] = this.settable;
    data['retained'] = this.retained;
    data['unit'] = this.unit;
    data['datatype'] = this.datatype;
    data['format'] = this.format;
    return data;
  }

  @override
  bool operator ==(other) {
    return (other is Property) &&
        "${other.parentId}/${other.id}" == "$parentId/$id";
  }

  int get hashCode => parentId.hashCode ^ id.hashCode;
}
