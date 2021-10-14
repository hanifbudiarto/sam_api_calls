part of sam_models_users;

class City {
  /*
  "id": "744",
  "name": "Witbank",
  "country_code": "ZAF",
  "district": "Mpumalanga"
   */

  late final String id;
  late final String name, countryCode, district;

  City(
      {required this.id,
      required this.name,
      required this.countryCode,
      required this.district});

  City.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.name = json['name'].toString();
    this.countryCode = json['country_code'];
    this.district = json['district'];
  }
}
