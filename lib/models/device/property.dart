import 'package:flutter/material.dart';

class Property {
  String parentId;
  String id;
  String name;
  bool settable;
  bool retained;
  String unit;
  String datatype;
  String format;

  Property(
      {@required this.parentId,
        this.id,
        this.name,
        this.settable,
        this.retained,
        this.unit,
        this.datatype,
        this.format});

  factory Property.copyFrom(Property prop) {
    return Property(
        parentId: prop.parentId,
        id: prop.id,
        name: prop.name,
        settable: prop.settable,
        retained: prop.retained,
        unit: prop.unit,
        datatype: prop.datatype,
        format: prop.format);
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

  operator ==(prop) => "${prop.parentId}/${prop.id}" == "$parentId/$id";

  int get hashCode => parentId.hashCode ^ id.hashCode;
}