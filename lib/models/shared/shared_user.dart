part of sam_models_shared;

class SharedUser {
  late final String sharedItemId;
  late final List<UserProfile> users;

  SharedUser({required this.sharedItemId, required this.users});

  SharedUser.fromJson(Map<String, dynamic> json) {
    List<UserProfile> profiles = [];

    if (json.containsKey('shared_users')) {
      var list = json['shared_users'] as List;
      profiles = list.map((dev) => UserProfile.fromJson(dev)).toList();
    }

    this.sharedItemId = json.containsKey('device_id')
        ? json['device_id'].toString()
        : json['analytic_id'].toString();
    this.users = profiles;
  }
}
