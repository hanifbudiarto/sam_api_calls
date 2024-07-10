part of sam_models_users;

class UserAccount {
  final String userId;
  final String userFname, userLname;
  final String userEmail, userPhone;
  final String userAvatar;
  final String userPassword;

  final String orgName, orgAddr1, orgAddr2, orgCity;
  final String orgProvince, orgCountry, orgZip;
  final String orgWeb, orgEmail, orgPhone;

  UserAccount({
    required this.userId,
    this.userFname = "",
    this.userLname = "",
    this.userEmail = "",
    this.userPhone = "",
    this.userAvatar = "",
    this.userPassword = "",
    this.orgName = "",
    this.orgAddr1 = "",
    this.orgAddr2 = "",
    this.orgCity = "",
    this.orgProvince = "",
    this.orgCountry = "",
    this.orgZip = "",
    this.orgWeb = "",
    this.orgEmail = "",
    this.orgPhone = "",
  });

  UserAccount.fromJson(Map<String, dynamic> json)
      : this.userId = json['user_id'].toString(),
        this.userFname = ifNullReturnEmpty(json['user_fname']),
        this.userLname = ifNullReturnEmpty(json['user_lname']),
        this.userEmail = ifNullReturnEmpty(json['user_email']),
        this.userPhone = ifNullReturnEmpty(json['user_phone']),
        this.userAvatar = ifNullReturnEmpty(json['user_avatar']),
        this.orgName = ifNullReturnEmpty(json['org_name']),
        this.orgAddr1 = ifNullReturnEmpty(json['org_addr1']),
        this.orgAddr2 = ifNullReturnEmpty(json['org_addr2']),
        this.orgCity = ifNullReturnEmpty(json['org_city']),
        this.orgProvince = ifNullReturnEmpty(json['org_province']),
        this.orgCountry = ifNullReturnEmpty(json['org_country']),
        this.orgZip = ifNullReturnEmpty(json['org_zip']),
        this.orgWeb = ifNullReturnEmpty(json['org_web']),
        this.orgEmail = ifNullReturnEmpty(json['org_email']),
        this.orgPhone = ifNullReturnEmpty(json['org_phone']),
        this.userPassword = ifNullReturnEmpty(json['user_password']);
}
