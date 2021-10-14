part of sam_models_devices;

class WgtElements {
  late final String id;
  late final List<String> resources;

  WgtElements({required this.id, required this.resources});

  WgtElements.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    List<String> res = [];
    res = List<String>.from(json['resources']);

    this.resources = res;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resources'] = this.resources;
    return data;
  }
}
