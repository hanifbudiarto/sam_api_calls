part of sam_models_dashboards;

class DashboardProfile {
  late final String id;
  late final String name;
  late final DashboardProfileData data;

  DashboardProfile(
      {required this.id, required this.name, required this.data});

  DashboardProfile.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.name = json['name'];
    this.data = DashboardProfileData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();

    result['name'] = name;
    result['data'] = data.toJson();

    return result;
  }

  @override
  bool operator ==(other) {
    return (other is DashboardProfile) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}