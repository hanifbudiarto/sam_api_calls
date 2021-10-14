part of sam_models_dashboards;

class DashboardProfiles {
  late final List<DashboardProfile> list;

  DashboardProfiles({required this.list});

  DashboardProfiles.fromJson(Map<String, dynamic> json) {
    List<DashboardProfile> dashboardProfiles = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      dashboardProfiles =
          list.map((item) => DashboardProfile.fromJson(item)).toList();
    }

    this.list = dashboardProfiles;
  }
}
