part of sam_models_users;

class UserAvatar {
  late final String avatar;

  UserAvatar({required this.avatar});

  UserAvatar.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('body')) {
      this.avatar = json['body']['user_avatar'];
    }
  }
}
