part of sam_models_devices;

class WgtElements {
  final String id;
  final List<String> resources;

  WgtElements({required this.id, this.resources = const <String>[]});

  WgtElements.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        this.resources = List<String>.from(json['resources']);

  Map<String, dynamic> toJson() => {'id': this.id, 'resources': this.resources};
}
