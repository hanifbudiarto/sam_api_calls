part of sam_models_users;

class City {
  /*
  "id": "744",
  "name": "Witbank",
  "country_code": "ZAF",
  "district": "Mpumalanga"
   */

  final String id;
  final String name, countryCode, district;

  City(
      {required this.id,
      this.name = "",
      this.countryCode = "",
      this.district = ""});

  City.fromJson(Map<String, dynamic> json)
      : this.id = json['id'].toString(),
        this.name = ifNullReturnEmpty(json['name']),
        this.countryCode = ifNullReturnEmpty(json['country_code']),
        this.district = ifNullReturnEmpty(json['district']);
}
