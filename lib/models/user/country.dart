part of sam_models_users;

class Country {
  /*
  "code": "IDN",
  "code2": "ID",
  "name": "Indonesia",
  "continent": "Asia",
  "region": "Southeast Asia"
   */

  late final String code;
  late final String code2;
  late final String name, continent, region;

  Country(
      {required this.code,
      required this.code2,
      required this.name,
      required this.continent,
      required this.region});

  Country.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.code2 = json['code2'];
    this.name = json['name'];
    this.continent = json['continent'];
    this.region = json['region'];
  }
}
