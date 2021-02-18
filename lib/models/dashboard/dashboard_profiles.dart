import 'dashboard_profile.dart';

class DashboardProfiles {
  final List<DashboardProfile> list;

  DashboardProfiles({this.list});

  factory DashboardProfiles.fromJson(Map<String, dynamic> json) {
    List<DashboardProfile> dashboardProfiles = [];

    if (json.containsKey("body")) {
      var list = json["body"] as List;
      dashboardProfiles =
          list.map((item) => DashboardProfile.fromJson(item)).toList();
    }

    return DashboardProfiles(list: dashboardProfiles);
  }
}
