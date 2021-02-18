class UserAvatar {
  String avatar;

  UserAvatar({this.avatar});

  factory UserAvatar.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey("body")) return null;

    return UserAvatar(avatar: json["body"]["user_avatar"]);
  }
}
