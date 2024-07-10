part of sam_models_users;

class UserAvatar {
  final String avatar;

  UserAvatar({this.avatar = ""});

  UserAvatar.fromJson(Map<String, dynamic> json)
      : this.avatar = (json.containsKey('body'))
            ? ifNullReturnEmpty(json['body']['user_avatar'])
            : '';
}
