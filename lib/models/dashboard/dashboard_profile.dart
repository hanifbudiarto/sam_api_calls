import 'package:flutter/material.dart';

import 'dashboard_profile_data.dart';

class DashboardProfile {
  String id;
  String name;
  DashboardProfileData data;

  DashboardProfile(
      {@required this.id, @required this.name, @required this.data});

  factory DashboardProfile.fromJson(Map<String, dynamic> json) {
    return DashboardProfile(
        id: json["id"].toString(),
        name: json["name"],
        data: DashboardProfileData.fromJson(json["data"]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();

    result["name"] = name;
    result["data"] = data.toJson();

    return result;
  }

  @override
  operator ==(other) => other.id == id;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}