part of sam_models_devices;

class Property {
  String parentId;
  final String id;
  String name;
  bool settable;
  bool retained;
  String unit;
  String datatype;
  String format;

  Property(
      {required this.parentId,
      required this.id,
      this.name = "",
      this.settable = false,
      this.retained = false,
      this.unit = "",
      this.datatype = "string",
      this.format = ""});

  static Property copyFrom(Property prop) {
    return Property(
        id: prop.id,
        parentId: prop.parentId,
        name: prop.name,
        settable: prop.settable,
        retained: prop.retained,
        unit: prop.unit,
        datatype: prop.datatype,
        format: prop.format);
  }

  Property.fromJson(String parentId, Map<String, dynamic> json)
      : this.parentId = parentId,
        id = json['id'].toString(),
        name = ifNullReturnEmpty(json['name']),
        settable = json['settable'] == true,
        retained = json['retained'] == true,
        unit = ifNullReturnEmpty(json['unit']),
        datatype = ifNullReturnEmpty(json['datatype']),
        format = ifNullReturnEmpty(json['format']);

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'settable': this.settable,
        'retained': this.retained,
        'unit': this.unit,
        'datatype': this.datatype,
        'format': this.format
      };

  @override
  bool operator ==(other) {
    return (other is Property) &&
        "${other.parentId}/${other.id}" == "$parentId/$id";
  }

  int get hashCode => parentId.hashCode ^ id.hashCode;
}
