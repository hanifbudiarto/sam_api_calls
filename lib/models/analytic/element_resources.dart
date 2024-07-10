part of sam_models_analytics;

class ElementResources {
  final String elementId;
  final List<String> resourcesId;
  final List<Resource> resources;

  ElementResources(
      {this.elementId = "",
      this.resourcesId = const <String>[],
      this.resources = const <Resource>[]});

  ElementResources.fromJson(Map<String, dynamic> json)
      : this.elementId = json.containsKey('element_id') && json['element_id'] != null
            ? ifNullReturnEmpty(json['element_id'])
            : "",
        this.resourcesId = (json['resources_id'] as List).length > 0
            ? (json['resources_id'] as List).map((e) => e.toString()).toList()
            : [],
        this.resources = [];

  Map<String, dynamic> toJson() => {
        'element_id': elementId,
        'resources_id':
            this.resources.map((res) => res.resourceId.toString()).toList()
      };
}
