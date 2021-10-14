part of sam_models_users;

class UserAccount {
  late final String userId;
  late final String userFname, userLname;
  late final String userEmail, userPhone;
  late final String userAvatar;
  late final String userPassword;

  late final String orgName, orgAddr1, orgAddr2, orgCity;
  late final String orgProvince, orgCountry, orgZip;
  late final String orgWeb, orgEmail, orgPhone;

  UserAccount(
      {required this.userId,
      required this.userFname,
      required this.userLname,
      required this.userEmail,
      required this.userPhone,
      required this.userAvatar,
      required this.userPassword,
      required this.orgName,
      required this.orgAddr1,
      required this.orgAddr2,
      required this.orgCity,
      required this.orgProvince,
      required this.orgCountry,
      required this.orgZip,
      required this.orgWeb,
      required this.orgEmail,
      required this.orgPhone});

  UserAccount.fromJson(Map<String, dynamic> json) {
    this.userId = json['user_id'];
    this.userFname = json['user_fname'];
    this.userLname = json['user_lname'];
    this.userEmail = json['user_email'];
    this.userPhone = json['user_phone'];
    this.userAvatar = ifNull(json['user_avatar']);
    this.orgName = ifNull(json['org_name']);
    this.orgAddr1 = ifNull(json['org_addr1']);
    this.orgAddr2 = ifNull(json['org_addr2']);
    this.orgCity = ifNull(json['org_city']);
    this.orgProvince = ifNull(json['org_province']);
    this.orgCountry = ifNull(json['org_country']);
    this.orgZip = ifNull(json['org_zip']);
    this.orgWeb = ifNull(json['org_web']);
    this.orgEmail = ifNull(json['org_email']);
    this.orgPhone = ifNull(json['org_phone']);
  }

  static dynamic ifNull(dynamic jsonValue) {
    if (jsonValue.toString() == 'null') {
      return '';
    } else
      return jsonValue;
  }
}
