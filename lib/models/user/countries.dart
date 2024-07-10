part of sam_models_users;

class Countries {
  final List<Country> list;

  Countries({this.list = const <Country>[]});

  static List<Country> getList(Map<String, dynamic> json) {
    List<Country> countries = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      countries = list.map((item) => Country.fromJson(item)).toList();
    }

    return countries;
  }

  Countries.fromJson(Map<String, dynamic> json) : this.list = getList(json);
}
