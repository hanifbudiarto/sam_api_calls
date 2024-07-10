part of sam_models_dashboards;

class DashboardProfile {
  final String id;
  final String name;
  final DashboardProfileData data;

  DashboardProfile({required this.id, this.name = "", this.data = const DashboardProfileData()});

  DashboardProfile.fromJson(Map<String, dynamic> json)
      : this.id = json['id'].toString(),
        this.name = ifNullReturnEmpty(json['name']),
        this.data = DashboardProfileData.fromJson(json['data']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'data': data.toJson(),
      };

  @override
  bool operator ==(other) {
    return (other is DashboardProfile) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
