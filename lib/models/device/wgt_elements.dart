class WgtElements {
  String id;
  List<String> resources;

  WgtElements({this.id, this.resources});

  WgtElements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resources = json['resources'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resources'] = this.resources;
    return data;
  }
}
