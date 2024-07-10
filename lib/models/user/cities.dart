part of sam_models_users;

class Cities {
  final List<City> list;

  Cities({this.list = const <City>[]});

  static List<City> getList(Map<String, dynamic> json) {
    List<City> cities = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      cities = list.map((item) => City.fromJson(item)).toList();
    }
    return cities;
  }

  Cities.fromJson(Map<String, dynamic> json) : this.list = getList(json);
}
