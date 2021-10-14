part of sam_models_users;

class Cities {
  late final List<City> list;

  Cities({required this.list});

  Cities.fromJson(Map<String, dynamic> json) {
    List<City> cities = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      cities = list.map((item) => City.fromJson(item)).toList();
    }
    this.list = cities;
  }
}
