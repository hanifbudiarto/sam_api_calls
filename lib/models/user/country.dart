
class Country {
  /*
  "code": "IDN",
  "code2": "ID",
  "name": "Indonesia",
  "continent": "Asia",
  "region": "Southeast Asia"
   */

  String code;
  String code2;
  String name, continent, region;

  Country({this.code, this.code2, this.name, this.continent, this.region});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        code: json["code"],
        code2: json["code2"],
        name: json["name"],
        continent: json["continent"],
        region: json["region"]);
  }
}
