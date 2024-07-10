part of sam_models_shared;

class SharedUser {
  final String sharedItemId;
  final List<UserProfile> users;

  SharedUser({required this.sharedItemId, this.users = const <UserProfile>[]});

  SharedUser.fromJson(Map<String, dynamic> json)
      : this.sharedItemId = json.containsKey('device_id')
            ? json['device_id'].toString()
            : json['analytic_id'].toString(),
        this.users =
            (json.containsKey('shared_users') && json['shared_users'] != null)
                ? getUserProfiles(json)
                : [];

  static List<UserProfile> getUserProfiles(Map<String, dynamic> json) {
    List<UserProfile> profiles = [];
    var list = json['shared_users'] as List;
    profiles = list.map((dev) => UserProfile.fromJson(dev)).toList();

    return profiles;
  }
}
