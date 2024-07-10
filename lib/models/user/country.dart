part of sam_models_users;

class Country {
  /*
  "code": "IDN",
  "code2": "ID",
  "name": "Indonesia",
  "continent": "Asia",
  "region": "Southeast Asia"
   */

  final String code;
  final String code2;
  final String name, continent, region;

  Country(
      {required this.code,
      this.code2 = "",
      this.name = "",
      this.continent = "",
      this.region = ""});

  Country.fromJson(Map<String, dynamic> json)
      : this.code = json['code'].toString(),
        this.code2 = ifNullReturnEmpty(json['code2']),
        this.name = ifNullReturnEmpty(json['name']),
        this.continent = ifNullReturnEmpty(json['continent']),
        this.region = ifNullReturnEmpty(json['region']);
}
