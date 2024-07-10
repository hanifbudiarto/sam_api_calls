part of sam_models_dashboards;

class DashboardProfiles {
  final List<DashboardProfile> list;

  DashboardProfiles({this.list = const <DashboardProfile>[]});

  DashboardProfiles.fromJson(Map<String, dynamic> json)
      : this.list = getList(json);

  static List<DashboardProfile> getList(Map<String, dynamic>? json) {
    List<DashboardProfile> dashboardProfiles = [];

    if (json != null &&
        json.runtimeType != Null &&
        json.toString() != 'null' &&
        json.containsKey('body')) {
      var list = json['body'] as List;
      dashboardProfiles =
          list.map((item) => DashboardProfile.fromJson(item)).toList();
    }

    return dashboardProfiles;
  }
}
