class UserProfile {
  String userId;
  String userFname, userLname;
  String userEmail, userPhone;

  UserProfile(
      {this.userId,
      this.userFname,
      this.userLname,
      this.userEmail,
      this.userPhone});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("body")) {
      return UserProfile(
          userFname: json["body"]['user_fname'],
          userLname: json["body"]['user_lname'],
          userEmail: json["body"]['user_email'],
          userPhone: json["body"]['user_phone'],
          userId: json["body"]['user_id'].toString());
    }

    return null;
  }
}
