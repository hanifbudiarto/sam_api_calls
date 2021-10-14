part of sam_models_analytics;

class ElementResources {
  late String elementId;
  late List<String> resourcesId;
  late List<Resource> resources;

  ElementResources(
      {this.elementId = "",
      this.resourcesId = const <String>[],
      this.resources = const <Resource>[]});

  ElementResources.fromJson(Map<String, dynamic> json) {
    List<String> res = [];
    var map = json['resources_id'] as List;
    map.forEach((m) {
      res.add(m.toString());
    });
    if (json.containsKey('element_id')) {
      this.elementId = json['element_id'];
    } else {
      this.elementId = "";
    }
    this.resourcesId = res;
    this.resources = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();
    result['element_id'] = elementId;
    result['resources_id'] =
        this.resources.map((res) => res.resourceId.toString()).toList();
    return result;
  }
}
