import '../user/user.dart';

class SharedUser {
  final String sharedItemId;
  final List<UserProfile> users;

  SharedUser({this.sharedItemId, this.users});

  factory SharedUser.fromJson(Map<String, dynamic> json) {
    List<UserProfile> profiles = [];

    if (json.containsKey('shared_users')) {
      var list = json['shared_users'] as List;
      profiles = list.map((dev) => UserProfile.fromJson(dev)).toList();
    }

    return SharedUser(
        sharedItemId: json.containsKey("device_id")
            ? json["device_id"].toString()
            : json["analytic_id"].toString(),
        users: profiles);
  }
}
