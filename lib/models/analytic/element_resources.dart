import 'package:flutter/material.dart';

import 'resource.dart';

class ElementResources {
  String elementId;
  List<String> resourcesId;
  List<Resource> resources;

  ElementResources(
      {@required this.elementId, @required this.resourcesId, this.resources});

  factory ElementResources.fromJson(Map<String, dynamic> json) {
    List<String> res = [];
    var map = json["resources_id"] as List;
    map.forEach((m) {
      res.add(m.toString());
    });

    return ElementResources(elementId: json["element_id"], resourcesId: res);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();
    result["element_id"] = elementId;
    if (this.resources != null && resources.length > 0) {
      result["resources_id"] =
          this.resources.map((res) => res.resourceId.toString()).toList();
    } else {
      result["resources_id"] = [];
    }

    return result;
  }
}