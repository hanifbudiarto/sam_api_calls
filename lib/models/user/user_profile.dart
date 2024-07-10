part of sam_models_users;

class UserProfile {
  final String userId;
  final String userFname, userLname;
  final String userEmail, userPhone;

  UserProfile(
      {required this.userId,
      this.userFname = "",
      this.userLname = "",
      this.userEmail = "",
      this.userPhone = ""});

  UserProfile.fromJson(Map<String, dynamic> json)
      : this.userFname = ifNullReturnEmpty(json['user_fname']),
        this.userLname = ifNullReturnEmpty(json['user_lname']),
        this.userEmail = ifNullReturnEmpty(json['user_email']),
        this.userPhone = ifNullReturnEmpty(json['user_phone']),
        this.userId = json['user_id'].toString();
}
