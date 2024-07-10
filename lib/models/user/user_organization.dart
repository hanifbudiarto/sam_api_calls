part of sam_models_users;

class UserOrganization {
  final String userId;
  String orgName, orgAddr1, orgAddr2, orgCity;
  String orgProvince, orgCountry, orgZip;
  String orgWeb, orgEmail, orgPhone;

  UserOrganization(
      {required this.userId,
      this.orgName = "",
      this.orgAddr1 = "",
      this.orgAddr2 = "",
      this.orgCity = "",
      this.orgProvince = "",
      this.orgCountry = "",
      this.orgZip = "",
      this.orgWeb = "",
      this.orgEmail = "",
      this.orgPhone = ""});
}
