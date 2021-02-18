class UserAccount {
  String userId;
  String userFname, userLname;
  String userEmail, userPhone;
  String userAvatar;
  String userPassword;

  String orgName, orgAddr1, orgAddr2, orgCity;
  String orgProvince, orgCountry, orgZip;
  String orgWeb, orgEmail, orgPhone;

  UserAccount(
      {this.userId,
      this.userFname,
      this.userLname,
      this.userEmail,
      this.userPhone,
      this.userAvatar,
      this.userPassword,
      this.orgName,
      this.orgAddr1,
      this.orgAddr2,
      this.orgCity,
      this.orgProvince,
      this.orgCountry,
      this.orgZip,
      this.orgWeb,
      this.orgEmail,
      this.orgPhone});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      userId: json["user_id"],
      userFname: json["user_fname"],
      userLname: json["user_lname"],
      userEmail: json["user_email"],
      userPhone: json["user_phone"],
      userAvatar: ifNull(json["user_avatar"]),
      orgName: ifNull(json["org_name"]),
      orgAddr1: ifNull(json["org_addr1"]),
      orgAddr2: ifNull(json["org_addr2"]),
      orgCity: ifNull(json["org_city"]),
      orgProvince: ifNull(json["org_province"]),
      orgCountry: ifNull(json["org_country"]),
      orgZip: ifNull(json["org_zip"]),
      orgWeb: ifNull(json["org_web"]),
      orgEmail: ifNull(json["org_email"]),
      orgPhone: ifNull(json["org_phone"])
    );
  }

  static dynamic ifNull(dynamic jsonValue) {
    if (jsonValue.toString() == "null") {
      return "";
    }
    else return jsonValue;
  }
}

