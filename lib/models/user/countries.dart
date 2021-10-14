part of sam_models_users;

class Countries {
  late final List<Country> list;

  Countries({required this.list});

  Countries.fromJson(Map<String, dynamic> json) {
    List<Country> countries = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      countries = list.map((item) => Country.fromJson(item)).toList();
    }

    this.list = countries;
  }
}
