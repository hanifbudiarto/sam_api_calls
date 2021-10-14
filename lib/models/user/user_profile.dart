part of sam_models_users;

class UserProfile {
  late final String userId;
  late final String userFname, userLname;
  late final String userEmail, userPhone;

  UserProfile(
      {required this.userId,
      required this.userFname,
      required this.userLname,
      required this.userEmail,
      required this.userPhone});

  UserProfile.fromJson(Map<String, dynamic> json) {
    this.userFname = json['user_fname'];
    this.userLname = json['user_lname'];
    this.userEmail = json['user_email'];
    this.userPhone = json['user_phone'];
    this.userId = json['user_id'].toString();
  }
}
